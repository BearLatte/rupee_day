import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/common/common_picker.dart';
import 'package:rupee_day/common/common_snackbar.dart';
import 'package:rupee_day/models/order_list_item_model.dart';
import 'package:rupee_day/router/app_routes.dart';

import '../models/feedback_type_model.dart';

class FeedbackGenerateController extends GetxController {
  TextEditingController feedbackTypeController = TextEditingController();
  TextEditingController feedbackDescController = TextEditingController();
  late OrderListItemModel order;
  List<FeedbackTypeModel> types = [];
  List<String> images = [];
  var currentFeedbackType = FeedbackTypeModel('', null).obs;

  void showTypesBottomSheet() async {
    debugPrint('DEBUG:  去选择类型');

    var result = await CommonPicker.showPicker(
      context: Get.context!,
      value: 0,
      options: types.map((e) => e.feedBacktype).toList(),
    );

    if (result != null) {
      currentFeedbackType.value = types[result];
      feedbackTypeController.text = currentFeedbackType.value.feedBacktype;
    }
  }

  void onSubmit() {
    if (currentFeedbackType.value.feedBacktype.isEmpty) {
      return CommonSnackbar.showSnackbar('Please choose type of question', type: SnackType.info);
    }

    if (feedbackDescController.text.trim().isEmpty) {
      return CommonSnackbar.showSnackbar('Please enter the question description!', type: SnackType.info);
    }

    NetworkApi.saveFeedback(
      orderNumber: order.loanOrderNo,
      feedBackType: currentFeedbackType.value.feedBacktype,
      feedBackContent: feedbackDescController.text,
      feedBackImg: images.isEmpty ? null : jsonEncode(images),
      successCallback: () {
        Get.offNamed(AppRoutes.FeedbackGenerateSuccess);
      },
    );
  }
}
