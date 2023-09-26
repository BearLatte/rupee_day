import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/common/common_snackbar.dart';
import 'package:rupee_day/global/index.dart';
import 'package:rupee_day/models/login_result_model.dart';
import 'package:rupee_day/network/index.dart';
import 'package:rupee_day/router/app_routes.dart';

class LoginController extends GetxController {
  /// 倒计时按钮的标题
  var countDownText = 'Get OTP'.obs;

  /// 倒计时 timer 对象
  Timer? _timer;

  /// 是否同意服务协议
  var isPrivacyChecked = true.obs;

  /// 用户手机号
  TextEditingController phoneController = TextEditingController();

  /// 用户验证码
  TextEditingController otpController = TextEditingController();

  TapGestureRecognizer conditionsTapGesture = TapGestureRecognizer()
    ..onTap = () {
      debugPrint('DEBUG: 点击了 conditions ');
    };

  TapGestureRecognizer privacyTapGesture = TapGestureRecognizer()
    ..onTap = () {
      debugPrint('DEBUG: 点击了 privacy policy ');
    };

  void loginSplashBtnClicked() {
    Get.toNamed(AppRoutes.Login);
  }

  // 发送验证码按钮点击
  void getOtpOnPressed() {
    if (phoneController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar('Please enter a 10-digit mobile number', type: SnackType.error);
      return;
    }

    if (_timer != null) {
      CommonSnackbar.showSnackbar('OTP can only be sent once a minute.', title: 'Operate too frequently', type: SnackType.info);
      return;
    }

    NetworkApi.sendOTP(phoneController.text, countDown);
  }

  /// 开启倒计时
  void countDown() {
    int count = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      count--;
      countDownText.value = '$count s';
      if (count == 0) {
        t.cancel();
        _timer = null;
        countDownText.value = 'Get OTP';
      }
    });
  }

  void onLogin() async {
    if (phoneController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter a 10-digit mobile number',
        type: SnackType.error,
      );
      return;
    }

    if (otpController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter correct OTP!',
        type: SnackType.error,
      );
      return;
    }

    if (!isPrivacyChecked.value) {
      CommonSnackbar.showSnackbar(
        'Please agree with our policy to continue!',
        type: SnackType.error,
      );
      return;
    }

    LoginResultModel model = await NetworkApi.login(phoneController.text, otpController.text);
    Global.loginSuccessAction(model.loginToken, phoneController.text);
  }
}
