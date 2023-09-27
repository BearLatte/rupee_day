import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_color.dart';

class PhotoTipsView extends StatelessWidget {
  const PhotoTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Photo Tips',
      appBarColor: HexColor('#15173B'),
      isDarkStatusBar: false,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonImage(
                  src: 'asset/icons/tips_correct_icon.png',
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                Text(
                  'Demonstration',
                  style: TextStyle(
                    color: HexColor('#15173B'),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                Text(
                  'Please ensure the whole cotent involved and words clear.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: HexColor('#BCBCBC'),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tipsSubitem(
                      'asset/icons/tips_correct_front_icon.png',
                      'Aadhaar Front',
                    ),
                    tipsSubitem(
                      'asset/icons/tips_correct_back_icon.png',
                      'Aadhaar Back',
                    ),
                    tipsSubitem(
                      'asset/icons/tips_correct_pan_icon.png',
                      'Aadhaar Front',
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                Divider(height: 1, color: HexColor('#dddddd')),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                const CommonImage(src: 'asset/icons/tips_error_icon.png'),
                Text(
                  'Error example',
                  style: TextStyle(
                    color: HexColor('#E14A25'),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tipsSubitem(
                      'asset/icons/tips_error_front_icon.png',
                      'Card shall not\noutside the frame',
                    ),
                    tipsSubitem(
                      'asset/icons/tips_error_back_icon.png',
                      'Photo shall not\nbe blurred',
                    ),
                    tipsSubitem(
                      'asset/icons/tips_error_pan_icon.png',
                      'No reflection\nlight on it',
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 75.0)),
                CommonTextButton(
                  'I already Know',
                  width: 265,
                  height: 50,
                  borderRadius: 25,
                  backgroundColor: HexColor('#15173B'),
                  onTap: () => Get.back(result: 'ok'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tipsSubitem(String icon, String title) {
    return Column(
      children: [
        CommonImage(src: icon),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, color: HexColor('#15173B')),
        )
      ],
    );
  }
}
