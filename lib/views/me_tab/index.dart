import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_color.dart';

import '../../Controllers/me_controller.dart';
import '../../router/app_routes.dart';

class MeTab extends StatelessWidget {
  const MeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MeController>();
    return Obx(
      () => CommonView(
        isShowBackBtn: false,
        isDarkStatusBar: false,
        title: 'Me',
        actions: [
          if (controller.isLogin.value)
            SizedBox(
              width: 44,
              height: 44,
              child: IconButton(onPressed: controller.logout, icon: const CommonImage(src: 'asset/icons/logout_icon.png')),
            ),
        ],
        child: Stack(
          children: [
            CommonImage(src: 'asset/images/order_detail_bg_img.png', width: double.infinity, height: MediaQuery.of(context).size.height * 0.4, fit: BoxFit.fill),
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      CommonImage(
                        src: controller.isLogin.value ? 'asset/icons/logo_icon.png' : 'asset/icons/not_login_logo_icon.png',
                        width: 100,
                        height: 100,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      Text(controller.phoneNumber.value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: HexColor('#E7AF74'), borderRadius: BorderRadius.circular(20)),
                        child: Wrap(
                          // spacing: 30,
                          runSpacing: 20,
                          children: [
                            wrapItem(
                              icon: 'asset/icons/profile_feedback_icon.png',
                              title: 'Feedback',
                              onPressed: () => Get.toNamed(AppRoutes.FeedbackList),
                            ),
                            wrapItem(icon: 'asset/icons/profile_card_icon.png', title: 'Change Bank Info', onPressed: controller.changeBankOnTap),
                            wrapItem(
                              icon: 'asset/icons/profile_privacy_icon.png',
                              title: 'Privacy Policy',
                              onPressed: () {
                                debugPrint('DEBUG: 打开 webView 查看隐私协议');
                              },
                            ),
                            wrapItem(icon: 'asset/icons/profile_about_icon.png', title: 'About Us', onPressed: controller.aboutUsOnTap)
                          ],
                        ),
                      ),
                      CommonImage(
                        src: 'asset/images/profile_bottom_img.png',
                        width: MediaQuery.of(context).size.width - 20,
                        fit: BoxFit.fill,
                      ),
                      if (controller.isLogin.value)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 20),
                          child: CommonTextButton(
                            'Logout',
                            width: 200,
                            height: 50,
                            borderRadius: 22,
                            onTap: controller.logout,
                            backgroundColor: HexColor('#15173B'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget wrapItem({required String icon, required String title, Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: (MediaQuery.of(Get.context!).size.width - 30 * 2) * 0.5,
        child: Column(
          children: <Widget>[
            CommonImage(src: icon),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            Text(title, style: TextStyle(color: HexColor('#15173B'), fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
