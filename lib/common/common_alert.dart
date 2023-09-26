import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/util/hex_corlor.dart';

enum AlertStyle { tips }

class CommonAlert {
  static Future<String> showAlert({
    AlertStyle style = AlertStyle.tips,
    String? message,
  }) async {
    return await Get.defaultDialog(
      title: '',
      backgroundColor: HexColor('#F6DDB2'),
      barrierDismissible: false,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: _contentWidget(style, message),
    );
  }

  static Widget _contentWidget(AlertStyle style, String? message) {
    return Column(children: [
      const CommonImage(src: 'asset/icons/alert_tips_icon.png'),
      Container(
        margin: const EdgeInsets.only(top: 4),
        child: Text(
          'TIPS',
          style: TextStyle(
            color: HexColor('#E09754'),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: Text(
          message ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(color: HexColor('#15173B'), fontSize: 18.0),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonTextButton(
            'Cancel',
            width: 130.0,
            height: 50.0,
            titleColor: HexColor('#E09754'),
            borderRadius: 25.0,
            backgroundColor: Colors.white,
            onTap: () => Get.back(result: 'cancel'),
          ),
          const Padding(padding: EdgeInsets.only(right: 7.0)),
          CommonTextButton(
            'Sure',
            width: 130.0,
            height: 50.0,
            borderRadius: 25.0,
            onTap: () => Get.back(result: 'confirm'),
          ),
        ],
      )
    ]);
  }
}
