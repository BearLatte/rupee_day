// ignore_for_file: non_constant_identifier_names
import 'package:advertising_id/advertising_id.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connection_network_type/connection_network_type.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_day/router/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static String IDFA_KEY = 'kIDFA_KEY';
  static String TOKEN_KEY = 'kTOKEN_KEY';
  static String LOGIN_KEY = 'kLOGIN_KEY';
  static String APP_LAUNCH_TIME = 'kAPP_LAUNCH_TIME';
  static String PHONE_NUMBER_KEY = 'kPHONE_NUMBER_KEY';

  static get isLogin async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(LOGIN_KEY) ?? false;
  }

  static get accessToken async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }

  static get currentLoginPhone async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PHONE_NUMBER_KEY);
  }

  static loginSuccessAction(String accessToken, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LOGIN_KEY, true);
    await prefs.setString(TOKEN_KEY, accessToken);
    await prefs.setString(PHONE_NUMBER_KEY, phoneNumber);
    Get.offAllNamed(AppRoutes.Home);
  }

  static logoutAction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LOGIN_KEY, false);
    await prefs.setString(TOKEN_KEY, '');
    await prefs.setString(PHONE_NUMBER_KEY, '');
    Get.offAllNamed(AppRoutes.Home);
  }

  static Future requestIdfa() async {
    PermissionStatus status = await Permission.appTrackingTransparency.request();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (status == PermissionStatus.granted) {
      String? idfaStr = await AdvertisingId.id();
      idfaStr = idfaStr == null ? '' : (idfaStr == '00000000-0000-0000-0000-000000000000' ? '' : idfaStr);
      preferences.setString(IDFA_KEY, idfaStr);
    }
  }

  static Future<String> checkNetworkType() async {
    final networkType = await ConnectionNetworkType().currentNetworkStatus();
    switch (networkType) {
      case NetworkStatus.mobile2G:
        return '2G';
      case NetworkStatus.mobile3G:
        return '3G';
      case NetworkStatus.mobile4G:
        return '4G';
      case NetworkStatus.mobile5G:
        return '5G';
      case NetworkStatus.wifi:
        return 'wifi';
      case NetworkStatus.otherMobile:
        return 'other';
      case NetworkStatus.unreachable:
        return 'unreachable';
    }
  }

  static Future<String> checkBatteryState() async {
    final status = await Battery().batteryState;
    switch (status) {
      case BatteryState.charging:
        return '2';
      case BatteryState.discharging:
        return '3';
      case BatteryState.full:
        return '5';
      default:
        return '4';
    }
  }
}
