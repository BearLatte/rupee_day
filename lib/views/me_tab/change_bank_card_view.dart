import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/change_bank_card_controller.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_corlor.dart';
import 'package:rupee_day/widget/hidden_keyboard_wraper.dart';

import '../../common/common_image.dart';
import '../../common/common_text_button.dart';

class ChangeBankCardView extends StatelessWidget {
  const ChangeBankCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangeBankCardController>();
    return HiddenKeyboardWrapper(
      child: CommonView(
        title: 'Bank Account',
        titleColor: HexColor('#333333'),
        backColor: HexColor('#333333'),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                bankCardInfoFormItem(
                  title: 'Account Number',
                  hintText: 'Account Number',
                  keyboardType: TextInputType.number,
                  controller: controller.cardNumController,
                ),
                bankCardInfoFormItem(title: 'Bank Name', hintText: 'Bank Name', controller: controller.bankNameController),
                bankCardInfoFormItem(
                  title: 'IFSC Code',
                  hintText: 'IFSC Code',
                  keyboardType: const TextInputType.numberWithOptions(signed: true),
                  controller: controller.ifscController,
                ),
                const CommonImage(src: 'asset/images/change_bank_card_bottom_img.png', width: double.infinity, fit: BoxFit.fill),
                const Spacer(),
                CommonTextButton('Submit', width: 265, height: 50, borderRadius: 25, backgroundColor: HexColor('#15173B'), onTap: controller.onSubmit)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bankCardInfoFormItem({required String title, String hintText = '', TextInputType? keyboardType, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(title, style: TextStyle(color: HexColor('#333333'), fontSize: 14)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: TextField(
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(hintText: hintText, hintStyle: TextStyle(color: HexColor('#999999')), border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
