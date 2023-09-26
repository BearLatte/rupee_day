import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/login_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/util/hex_corlor.dart';

class LoginSplashView extends StatelessWidget {
  const LoginSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor('#15173B'),
        child: Center(
          child: Stack(children: [
            CommonImage(
              width: MediaQuery.of(context).size.width,
              src: 'asset/images/login_splash_img.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              left: (MediaQuery.of(context).size.width - 300) * 0.5,
              bottom: 0,
              child: CommonTextButton(
                'Login now',
                titleColor: HexColor('#15173B'),
                titleSize: 30,
                width: 300,
                height: 60,
                borderRadius: 30.0,
                backgroundColor: Colors.white,
                boxShadow: BoxShadow(
                  color: HexColor('#E09754'),
                  offset: const Offset(0, 2),
                  blurRadius: 4.0,
                  blurStyle: BlurStyle.normal,
                ),
                onTap: () {
                  Get.find<LoginController>().loginSplashBtnClicked();
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
