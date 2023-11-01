import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event_success.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:rupee_day/global/index.dart';
import 'package:rupee_day/network/index.dart';
import 'package:rupee_day/router/index.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    initAdjust();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.downToUp,
      getPages: AppPages.routes,
      theme: ThemeData(colorScheme: ColorScheme.light(primary: HexColor('#E09754'))),
      builder: EasyLoading.init(),
      onInit: () async {
        await Global.requestIdfa();
        await (Connectivity().checkConnectivity());
      },
      onReady: () async {
        await NetworkApi.firstRequest();
        SharedPreferences fs = await SharedPreferences.getInstance();
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        fs.setInt(Global.APP_LAUNCH_TIME, timestamp);
      },
    );
  }

  void initAdjust() {
    AdjustConfig config = AdjustConfig('r5877m29itc0', AdjustEnvironment.production);
    config.logLevel = AdjustLogLevel.verbose;
    config.defaultTracker = 'AppStore';
    config.allowAdServicesInfoReading = true;
    config.allowIdfaReading = true;
    config.deactivateSKAdNetworkHandling();
    config.linkMeEnabled = true;
    config.urlStrategy = AdjustConfig.UrlStrategyChina;

    config.eventSuccessCallback = (AdjustEventSuccess eventSuccessData) {
      if (eventSuccessData.eventToken != null) {
        debugPrint('[Adjust]: Event token: ${eventSuccessData.eventToken}');
      }
      if (eventSuccessData.message != null) {
        debugPrint('[Adjust]: Message: ${eventSuccessData.message}');
      }
      if (eventSuccessData.timestamp != null) {
        debugPrint('[Adjust]: Timestamp: ${eventSuccessData.timestamp}');
      }
      if (eventSuccessData.adid != null) {
        debugPrint('[Adjust]: Adid: ${eventSuccessData.adid}');
      }
      if (eventSuccessData.callbackId != null) {
        debugPrint('[Adjust]: Callback ID: ${eventSuccessData.callbackId}');
      }
      if (eventSuccessData.jsonResponse != null) {
        debugPrint('[Adjust]: JSON response: ${eventSuccessData.jsonResponse}');
      }
    };
    Adjust.start(config);
  }
}
