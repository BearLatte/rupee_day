import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/util/hex_color.dart';

import '../models/user_info_model.dart';

enum AlertStyle { tips, loanPayFail }

class CommonAlert {
  static Future<String> showAlert({AlertStyle style = AlertStyle.tips, String? message, UserInfoModel? payFailModel}) async {
    return await Get.defaultDialog(
      title: '',
      backgroundColor: HexColor('#F6DDB2'),
      barrierDismissible: false,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: _contentWidget(style, message, payFailModel),
    );
  }

  static Widget _contentWidget(AlertStyle style, String? message, UserInfoModel? payFailModel) {
    return style == AlertStyle.tips ? _tipStyleDialog(message) : _payFailDialog(payFailModel);
  }

  static Widget _payFailDialog(UserInfoModel? payFailModel) {
    return Column(
      children: [
        Text(
          payFailModel?.payFailLoanName ?? '',
          style: TextStyle(color: HexColor('#E09754'), fontSize: 22, fontWeight: FontWeight.w600),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Order Number', style: TextStyle(color: HexColor('#999999'), fontSize: 14)),
              Text(
                payFailModel?.payFailLoanNo ?? '',
                style: TextStyle(color: HexColor('#333333'), fontSize: 14),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Tips\n${payFailModel?.payFailContent}',
            textAlign: TextAlign.center,
            style: TextStyle(color: HexColor('#15173B'), fontSize: 18),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 95, right: 95),
          child: CommonTextButton('OK', width: 145, height: 50, borderRadius: 25, onTap: () => Get.back(result: 'OK')),
        ),
      ],
    );
  }

  static Widget _tipStyleDialog(String? message) {
    return Column(
      children: [
        const CommonImage(src: 'asset/icons/alert_tips_icon.png'),
        Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              'TIPS',
              style: TextStyle(color: HexColor('#E09754'), fontSize: 22, fontWeight: FontWeight.w600),
            )),
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
            CommonTextButton('Sure', width: 130.0, height: 50.0, borderRadius: 25.0, onTap: () => Get.back(result: 'confirm')),
          ],
        )
      ],
    );
  }
}
