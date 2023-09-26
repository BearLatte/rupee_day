import 'package:get/get.dart';
import 'package:rupee_day/global/index.dart';

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
}
