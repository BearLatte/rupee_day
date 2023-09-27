import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_color.dart';

import '../../common/common_text_button.dart';

class FeedbackGenerateSuccessView extends StatelessWidget {
  const FeedbackGenerateSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonView(
      isDarkStatusBar: false,
      appBarColor: HexColor('#15173B'),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: const CommonImage(src: 'asset/icons/successed_icon.png'),
            ),
            Text('Submitted successfully', style: TextStyle(color: HexColor('#15173B'), fontSize: 20, fontWeight: FontWeight.w600)),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
              child: CommonTextButton('Ok', width: 265, height: 50, borderRadius: 25, backgroundColor: HexColor('#15173B'), onTap: () => Get.back()),
            ),
          ],
        ),
      ),
    );
  }
}
