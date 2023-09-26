import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackGenerateController extends GetxController {
  TextEditingController feedbackTypeController = TextEditingController();
  TextEditingController feedbackDescController = TextEditingController();
  List<String> images = [];

  void showTypesBottomSheet() {
    debugPrint('DEBUG:  去选择类型');
  }
}
