import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/common/common_snackbar.dart';

class ChangeBankCardController extends GetxController {
  TextEditingController cardNumController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();

  void onSubmit() async {
    if (cardNumController.text.trim().isEmpty) {
      return CommonSnackbar.showSnackbar('Account Number cannot be empty!');
    }

    if (bankNameController.text.trim().isEmpty) {
      return CommonSnackbar.showSnackbar('Bank Name cannot be empty!');
    }

    if (ifscController.text.trim().isEmpty) {
      return CommonSnackbar.showSnackbar('Bank Name cannot be empty!');
    }

    await NetworkApi.changeBankCard(
      cardNumber: cardNumController.text,
      bankName: bankNameController.text,
      ifscCode: ifscController.text,
    );

    Get.back();
  }
}
