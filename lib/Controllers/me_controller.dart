import 'package:get/get.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/global/index.dart';
import 'package:rupee_day/util/adjust_track_tool.dart';

import '../router/app_routes.dart';

class MeController extends GetxController {
  var isLogin = false.obs;
  var phoneNumber = 'Please log in'.obs;
  @override
  void onInit() {
    super.onInit();
    checkLoginState();
  }

  Future checkLoginState() async {
    isLogin.value = await Global.isLogin ?? false;
    phoneNumber.value = await Global.currentLoginPhone ?? 'Please log in';
  }

  void logout() async {
    await NetworkApi.logout();
    isLogin.value = false;
    Global.logoutAction();
  }

  void changeBankOnTap() {
    ADJustTrackTool.trackWith('nu6lzz');
    if (isLogin.value) {
      Get.toNamed(AppRoutes.ChangeBankCard);
    } else {
      Get.toNamed(AppRoutes.LoginSplash);
    }
  }

  void aboutUsOnTap() => Get.toNamed(AppRoutes.AboutUs);
}
