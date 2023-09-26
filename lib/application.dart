import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:rupee_day/global/index.dart';
import 'package:rupee_day/network/index.dart';
import 'package:rupee_day/router/index.dart';
import 'package:rupee_day/util/hex_corlor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.downToUp,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: HexColor('#E09754'),
        ),
      ),
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
}
