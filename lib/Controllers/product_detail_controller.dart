import 'dart:convert';

import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_day/common/common_alert.dart';
import 'package:rupee_day/common/common_snackbar.dart';
import 'package:rupee_day/global/index.dart';
import 'package:rupee_day/models/liveness_params_model.dart';
import 'package:rupee_day/models/purchase_result_model.dart';
import 'package:rupee_day/models/user_info_model.dart';
import 'package:rupee_day/network/index.dart';
import 'package:rupee_day/router/app_routes.dart';
import 'package:rupee_day/util/adjust_track_tool.dart';
import 'package:rupee_day/util/facebook_track_tool.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailController extends GetxController {
  late bool isRecommond;
  late String productId;
  late UserInfoModel userInfo;
  RxBool isAppleTestAccount = false.obs;
  final MethodChannel _methodChannel = const MethodChannel('rupeeDay.method.channel');

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  @override
  void onReady() {
    super.onReady();
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'livenessCompleted') {
        livenessCompletionsHandler(
          call.arguments['imgPath'],
          call.arguments['score'],
        );
      }

      if (call.method == 'takePhotoCompleted') {
        takePhotoCompletedHandler(call.arguments);
      }
    });
  }

  Future fetchUserInfo() async {
    userInfo = await NetworkApi.fetchUserInfo();
    isAppleTestAccount.value = userInfo.auditPhone == 1;
  }

  void loanBtnAction() async {
    if (isRecommond) {
      ADJustTrackTool.trackWith('aduk3j');
    }
    await fetchUserInfo();
    if (userInfo.userLiveness == 1) {
      configParamsAndPurchaseProduct();
    } else {
      final result = await CommonAlert.showAlert(
        style: AlertStyle.tips,
        message: 'Please upload a selfie photo before continuing.',
      );
      if (result == 'confirm') {
        PermissionStatus status = await Permission.camera.request();
        // Permission.camera.request();
        if (status != PermissionStatus.granted) {
          CommonSnackbar.showSnackbar(
            'You did not allow us to access the camera, which will help you obtain a loan. Would you like to set up authorization.',
            type: SnackType.info,
          );
          return;
        }
        if (userInfo.thirdLiveness == 'BJX') {
          // 拍摄人脸照片
          _methodChannel.invokeMethod('takeFacePhotoAction');
        } else {
          // 活体认证
          LivenessParamsModel params = await NetworkApi.fetchLivenessParams();
          _methodChannel.invokeMapMethod('liveness', params.toJson());
        }
      }
    }
  }

  void backAction() {
    if (isRecommond) {
      ADJustTrackTool.trackWith('l1hxxh');
    }
    Get.back();
  }

  void takePhotoCompletedHandler(String imgPath) {
    NetworkApi.livenessAuth(
      filePath: imgPath,
      faceScore: '5',
      success: loanBtnAction,
    );
  }

  void livenessCompletionsHandler(String imgPath, String livenessScore) {
    NetworkApi.livenessAuth(
      filePath: imgPath,
      faceScore: livenessScore,
      success: loanBtnAction,
    );
  }

  void configParamsAndPurchaseProduct() async {
    EasyLoading.show(status: 'placing an order...');
    Map<String, String> params = {'pXXXroXXductId': productId};
    Map<String, dynamic> loanData = {};
    Map<String, dynamic> userDevice = {};

    if (userInfo.auditPhone == 0) {
      PermissionStatus contactStatus = await Permission.contacts.request();
      if (contactStatus != PermissionStatus.granted) {
        EasyLoading.dismiss();
        CommonSnackbar.showSnackbar('You did not allow us to access the contacts. Allowing it will help you obtain a loan. Do you want to set up authorization.');
        return;
      } else {
        List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
        List<Map<String, Object>> phoneList = contacts.map((contact) => {'number': contact.phones.isEmpty ? '' : contact.phones.first.number, 'name': contact.displayName}).toList();
        loanData['phoneList'] = phoneList;
      }

      PermissionStatus locationStatus = await Permission.location.request();
      if (locationStatus != PermissionStatus.granted) {
        EasyLoading.dismiss();
        String result = await CommonAlert.showAlert(
          style: AlertStyle.tips,
          message: 'This feature requires you to authorize this app to open the location service\nHow to set it: open phone Settings -> Privacy -> Location service',
        );
        if (result == 'confirm') {
          openAppSettings();
        }
        return;
      } else {
        userDevice['gpsEnabled'] = true;
        Position locationData = await Geolocator.getCurrentPosition();
        userDevice['latitude'] = locationData.latitude;
        userDevice['longitude'] = locationData.longitude;
        var address = await GeoCode().reverseGeocoding(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
        );
        userDevice['city'] = address.city;
        userDevice['state'] = address.region;
      }
    }

    SharedPreferences fs = await SharedPreferences.getInstance();
    PackageInfo package = await PackageInfo.fromPlatform();
    IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
    List<dynamic>? languages = await Devicelocale.preferredLanguages;
    int launchTimestamp = fs.getInt(Global.APP_LAUNCH_TIME)!;
    String networkType = await Global.checkNetworkType();

    userDevice['sysType'] = 'iOS';
    userDevice['applyChannel'] = 'AppStore';
    userDevice['name'] = package.appName;
    userDevice['idfa'] = fs.getString(Global.IDFA_KEY);
    userDevice['udid'] = iosInfo.identifierForVendor;
    userDevice['idfv'] = iosInfo.identifierForVendor;
    userDevice['appOpenTime'] = launchTimestamp;
    userDevice['bootTime'] = launchTimestamp;
    userDevice['time'] = DateTime.now().millisecondsSinceEpoch - launchTimestamp;
    userDevice['languageList'] = jsonEncode(languages);
    userDevice['timezone'] = await FlutterNativeTimezone.getLocalTimezone();
    userDevice['lowPowerModeEnabled'] = await Battery().isInBatterySaveMode;
    userDevice['autoBrightnessEnabled'] = await ScreenBrightness().isAutoReset;
    userDevice['debug'] = false;
    userDevice['networkType'] = networkType;
    userDevice['is4G'] = networkType == '4G';
    userDevice['is5G'] = networkType == '5G';

    var info = await _methodChannel.invokeMethod('getStoageInfo');
    userDevice['internalTotalStorage'] = info?['internalTotalStorage'];
    userDevice['internalUsableStorage'] = info?['internalUsableStorage'];
    userDevice['percentValue'] = info?['percentValue'];
    userDevice['ramTotalSize'] = info?['internalTotalStorage'];
    userDevice['ramTotalSize'] = info?['internalUsableStorage'];
    userDevice['model'] = info?['model'];
    userDevice['simulator'] = info?['model'] == 'Simulator';
    userDevice['release'] = iosInfo.systemVersion;
    userDevice['versionCode'] = package.version;
    userDevice['brightness'] = info?['brightness'];

    Size screenSize = MediaQuery.of(Get.context!).size;
    var ratio = MediaQuery.of(Get.context!).devicePixelRatio;
    MediaQueryData? data = MediaQuery.maybeOf(Get.context!).nonEmptySizeOrNull();
    userDevice['screenWidth'] = screenSize.width.toInt();
    userDevice['screenHeight'] = screenSize.height.toInt();
    userDevice['resolution'] = '${(screenSize.width * ratio).toInt()} * ${(screenSize.height * ratio).toInt()}';
    double deviceWidth = data?.size.width ?? 0;
    double deviceHeight = data?.size.height ?? 0;
    userDevice['physicalSize'] = '${deviceWidth.toInt()}*${deviceHeight.toInt()}';

    userDevice['isPhone'] = iosInfo.model == 'iPhone';
    userDevice['isTablet'] = iosInfo.model == 'iPad';
    userDevice['batteryStatus'] = await Global.checkBatteryState();
    if (info?['model'] != 'Simulator') {
      int batteryLevel = await Battery().batteryLevel;
      userDevice['batteryLevel'] = batteryLevel;
      userDevice['batteryPct'] = '$batteryLevel%';
    }

    userDevice['batterySum'] = '100';
    userDevice['isCharging'] = (await Global.checkBatteryState()) == '2';
    loanData['userDevice'] = userDevice;
    params['lXXXoaXXnData'] = json.encode(loanData);

    PurchaseResultModel result = await NetworkApi.purchaseProduct(params);
    if (result.isFirstApply == 1) {
      ADJustTrackTool.trackWith('uulzq9');
      FacebookTrankTool.trackWith(FacebookTrackType.addToCard);
    }
    EasyLoading.dismiss();
    Get.offNamedUntil(
      AppRoutes.ProductPurchaseSuccessed,
      (route) => route.isFirst,
      arguments: result.productList,
    );
  }
}

extension on MediaQueryData? {
  MediaQueryData? nonEmptySizeOrNull() {
    if (this?.size.isEmpty ?? true) {
      return null;
    } else {
      return this;
    }
  }
}

/*
 void _configParamsAndPurchaseProduct() async {

   

   

    PurchaseProductModel? model = await NetworkService.purchaseProduct(params);
    if (model != null) {
      if (model.isFirstApply == 1) {
        ADJustTrackTool.trackWith('eqmzq8');
        FacebookTrankTool.trackWith(FacebookTrackType.addToCard);
      }

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/productPurchaseSuccessed',
          (route) => route.isFirst,
          arguments: {
            'products': model.productList,
            'isRecommend': widget.isRecommend
          },
        );
      }
    }
  }
 */
