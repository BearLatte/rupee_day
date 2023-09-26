// ignore_for_file: library_prefixes
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rupee_day/common/common_snackbar.dart';
import 'package:rupee_day/global/index.dart';
import 'package:rupee_day/router/app_routes.dart';
import 'package:rupee_day/util/md5_util.dart';
import 'package:rupee_day/util/random_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    switch (options.path) {
      case '/EZDyP/EhULCC':
        EasyLoading.show(
            status: 'login...', maskType: EasyLoadingMaskType.black);
      case '/EZDyP/lnTwMn/omxwY':
      case '/EZDyP/lnTwMn/juJeY':
      case '/EZDyP/lnTwMn/ZwOTB':
        break;
      default:
        EasyLoading.show(
            status: 'loading...', maskType: EasyLoadingMaskType.black);
    }

    options.headers['lang'] = 'en';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    PackageInfo package = await PackageInfo.fromPlatform();
    IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;

    // 配置 token
    if (options.path != '/EZDyP/ZEQZIN' &&
        options.path != '/EZDyP/BuGuN' &&
        options.path != '/EZDyP/EhULCC') {
      String token = await Global.accessToken;
      debugPrint('DEBUG: token = $token');
      options.headers['token'] = token;
    }

    Map<String, String?> deviceInfo = {};
    deviceInfo['appVersion'] = package.version;
    deviceInfo['bag'] = package.packageName;
    deviceInfo['brand'] = 'Apple';
    deviceInfo['channel'] = 'App Store';
    deviceInfo['deviceModel'] = iosInfo.name;
    deviceInfo['osVersion'] = iosInfo.systemVersion;
    deviceInfo['androidIdOrUdid'] = iosInfo.identifierForVendor;
    deviceInfo['gaidOrIdfa'] = preferences.getString(Global.IDFA_KEY) ?? '';
    deviceInfo['mac'] = '';
    deviceInfo['operationSys'] = 'iOS';
    options.headers['deviceInfo'] = jsonEncode(deviceInfo);

    // 参数排序，签名
    Map<String, dynamic> params = options.queryParameters;
    options.queryParameters = _configParameters(params);
    debugPrint('DEBUG: 请求参数${options.queryParameters}');

    handler.next(options);
  }

  // 统一处理参数签名
  static Map<String, dynamic> _configParameters(
      Map<String, dynamic>? parameters) {
    Map<String, dynamic> newParams;

    if (parameters == null) {
      newParams = {'nXXXonXXcestr': RandomUtil.generateRandomString(30)};
    } else {
      newParams = Map.from(parameters);
      newParams['nXXXonXXcestr'] = RandomUtil.generateRandomString(30);
    }

    String signKey = '&signKey=iYeXsbQTefsNWaAyFSDRBnkb';
    String keyString = _sortedMapWith(newParams) + signKey;
    newParams['rXXXeqXXSign'] = MD5Util.md5String(keyString);
    return newParams;
  }

  // 参数排序
  static String _sortedMapWith(Map<String, dynamic> params) {
    List<String> allKeys = params.keys.toList();
    allKeys.sort(
        (left, right) => left.toLowerCase().compareTo(right.toLowerCase()));

    var mapString = '';
    for (int i = 0; i < allKeys.length; i++) {
      String key = allKeys[i];
      String value = '${params[key]}';

      if (i == 0) {
        mapString = '$key=$value';
      } else {
        mapString = '$mapString&$key=$value';
      }
    }
    return mapString;
  }

  // @override
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    switch (response.requestOptions.path) {
      case '/EZDyP/lnTwMn/omxwY':
      case '/EZDyP/lnTwMn/ZwOTB':
        break;
      default:
        EasyLoading.dismiss();
    }

    Map<String, dynamic> result = {};
    Map<String, dynamic> data = Map.from(response.data);
    data.remove('rlkeswsultCode');
    data.remove('rlkeswsultMsg');

    int resultCode = response.data['rlkeswsultCode'];
    String resultMsg = response.data['rlkeswsultMsg'];
    result['data'] = data;
    result['resultCode'] = resultCode;
    result['resultMsg'] = resultMsg;
    response.data = result;

    if (resultCode == -1) {
      GetX.Get.toNamed(AppRoutes.LoginSplash);
      return;
    }
    if (resultCode == 0) {
      EasyLoading.dismiss();
      CommonSnackbar.showSnackbar(resultMsg, type: SnackType.error);
      return;
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    EasyLoading.dismiss();
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        CommonSnackbar.showSnackbar(
          'The network connection timeout!',
          title: 'Network Error',
          type: SnackType.error,
        );
        break;
      case DioExceptionType.receiveTimeout:
        CommonSnackbar.showSnackbar(
          'The network data receiving timeout!',
          title: 'Network Error',
          type: SnackType.error,
        );
        break;
      case DioExceptionType.sendTimeout:
        CommonSnackbar.showSnackbar(
          'The request send timeout!',
          title: 'Network Error',
          type: SnackType.error,
        );
        break;
      case DioExceptionType.badResponse:
        CommonSnackbar.showSnackbar(
          'The response is bad!',
          title: 'Network Error',
          type: SnackType.error,
        );
        break;
      case DioExceptionType.cancel:
        CommonSnackbar.showSnackbar(
          'The request is canceled!',
          title: 'Network Error',
          type: SnackType.error,
        );
        break;

      case DioExceptionType.connectionError:
        CommonSnackbar.showSnackbar(
          'Connection error!',
          title: 'Network Error',
          type: SnackType.error,
        );
        break;
      default:
        CommonSnackbar.showSnackbar(
          'Unknown Error!',
          title: 'Network Error',
          type: SnackType.error,
        );
        break;
    }
  }
}
