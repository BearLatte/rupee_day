import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rupee_day/Controllers/login_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/router/app_routes.dart';
import 'package:rupee_day/util/hex_corlor.dart';
import 'package:rupee_day/widget/hidden_keyboard_wraper.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      backColor: HexColor('#333333'),
      backAction: () => Get.offAllNamed(AppRoutes.Home),
      child: HiddenKeyboardWrapper(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [HexColor('#FBF0D8'), HexColor('#DF9857')],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CommonImage(src: 'asset/icons/logo_icon.png'),
                  _contentWidget(context),
                  _privacyView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0, bottom: 20.0),
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            const CommonImage(src: 'asset/icons/title_icon.png'),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                Text(
                  'Mobile number',
                  style: TextStyle(
                    color: HexColor('#333333'),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20.0)),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: const CommonImage(src: 'asset/icons/phone_icon.png'),
                ),
                Expanded(
                  child: TextField(
                    controller: controller.phoneController,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16.0, color: HexColor('#333333')),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Mobile number',
                      hintStyle: TextStyle(color: HexColor('#999999'), fontSize: 16),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                )
              ],
            ),
            Divider(color: HexColor('#F2F2F2'), height: 1),
            const Padding(padding: EdgeInsets.only(bottom: 25.0)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                Text(
                  'One-time-Password',
                  style: TextStyle(
                    color: HexColor('#333333'),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: PinCodeTextField(
                length: 5,
                enableActiveFill: true,
                appContext: context,
                controller: controller.otpController,
                textStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#15173B'),
                ),
                cursorColor: HexColor('#DADADA'),
                animationType: AnimationType.none,
                pinTheme: PinTheme(
                  fieldWidth: 50.0,
                  fieldHeight: 50.0,
                  activeColor: HexColor('#F2F2F2'),
                  inactiveColor: HexColor('#F2F2F2'),
                  selectedColor: HexColor('#F2F2F2'),
                  activeFillColor: HexColor('#F2F2F2'),
                  inactiveFillColor: HexColor('#F2F2F2'),
                  selectedFillColor: HexColor('#F2F2F2'),
                  shape: PinCodeFieldShape.circle,
                ),
              ),
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                GestureDetector(
                  onTap: controller.getOtpOnPressed,
                  child: Obx(
                    () => Text(
                      controller.countDownText.value,
                      style: TextStyle(
                        color: HexColor('#E09754'),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 40.0),
              child: CommonTextButton(
                'Login now',
                width: 238,
                height: 50,
                borderRadius: 25,
                backgroundColor: HexColor('#15173B'),
                onTap: controller.onLogin,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _privacyView() {
    TextStyle defaultStyle = TextStyle(
      fontSize: 14.0,
      color: HexColor('#333333'),
    );

    TextStyle highlightedStyle = TextStyle(
      fontSize: 14.0,
      color: HexColor('#F6DDB2'),
      decoration: TextDecoration.underline,
    );
    return Container(
      padding: const EdgeInsets.only(left: 35, right: 35.0),
      child: Row(children: [
        InkWell(
          onTap: () => controller.isPrivacyChecked.value = !controller.isPrivacyChecked.value,
          child: Container(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Obx(
              () => CommonImage(
                src: controller.isPrivacyChecked.value ? 'asset/icons/check_box_selected.png' : 'asset/icons/check_box.png',
              ),
            ),
          ),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By continuing you agree our ',
                  style: defaultStyle,
                ),
                TextSpan(
                  text: 'Terms & Conditions',
                  style: highlightedStyle,
                  recognizer: controller.conditionsTapGesture,
                ),
                TextSpan(
                  text: ' and ',
                  style: defaultStyle,
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: highlightedStyle,
                  recognizer: controller.privacyTapGesture,
                ),
                TextSpan(
                  text: '.',
                  style: defaultStyle,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
