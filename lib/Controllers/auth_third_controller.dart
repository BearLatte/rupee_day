// ignore_for_file: invalid_use_of_protected_member
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';
import 'package:rupee_day/common/common_alert.dart';
import 'package:rupee_day/common/common_picker.dart';
import 'package:rupee_day/common/common_snackbar.dart';
import 'package:rupee_day/models/auth_info_model.dart';
import 'package:rupee_day/models/auth_params_model.dart';
import 'package:rupee_day/models/product_detail_model.dart';
import 'package:rupee_day/network/index.dart';
import 'package:rupee_day/router/app_routes.dart';

class AuthThirdController extends GetxController {
  RxList inputControllers = [].obs;
  late AuthInfoModel authInfo;
  List<InputControllerModel> baseInputControllers = [];
  var isEnableInput = false.obs;

  @override
  void onInit() {
    fetchAuthInfo();
    super.onInit();
  }

  void fetchAuthInfo() async {
    AuthInfoModel info = await NetworkApi.fetchAuthInfo();
    authInfo = info;
    isEnableInput.value = info.auditPhone == 1;

    for (int i = 0; i < info.contactNum; i++) {
      baseInputControllers.add(InputControllerModel());
    }
    inputControllers.value = baseInputControllers;
  }

  void addContact() {
    List<InputControllerModel> controllers = [];
    for (var i = 0; i < baseInputControllers.length; i++) {
      controllers.add(baseInputControllers[i]);
    }
    controllers.insert(0, InputControllerModel());
    baseInputControllers = controllers;
    inputControllers.value = controllers;
  }

  void selectRelationAction(int index) async {
    int? selectedIndex = await CommonPicker.showPicker(
      context: Get.context!,
      value: 0,
      options: authInfo.relationList,
    );

    if (selectedIndex != null) {
      inputControllers[index].relationController.text =
          authInfo.relationList[selectedIndex];
    }
  }

  void selectPhoneNumberAction(int index) async {
    debugPrint('DEBUG: 选择电话号码，当前选择的索引是$index');
    if (isEnableInput.value) return;
    final contact = await FlutterContactPicker().selectContact();
    if (contact == null) return;
    inputControllers[index].contactNameController.text = contact.fullName;
    inputControllers[index].phoneNumberController.text =
        contact.phoneNumbers?.first;
  }

  void onSubmit() async {
    List<Map<String, String>> contacts = [];
    for (InputControllerModel controllerModel in inputControllers.value) {
      if (controllerModel.relationController.text.trim().isEmpty ||
          controllerModel.phoneNumberController.text.trim().isEmpty ||
          controllerModel.contactNameController.text.trim().isEmpty) {
        CommonSnackbar.showSnackbar('Please complete each item in the list!');
        return;
      }
      contacts.add({
        'contactName': controllerModel.contactNameController.text,
        'contactPhone': controllerModel.phoneNumberController.text,
        'contactRelation': controllerModel.relationController.text
      });
    }

    String result = await CommonAlert.showAlert(
      style: AlertStyle.tips,
      message:
          'After the information is submitted, you can only change the bank information. So please make sure that other information is correct.',
    );

    if (result == 'confirm') {
      AuthParamsModel params =
          AuthParamsModel(authStep: '3', contactList: jsonEncode(contacts));
      NetworkApi.authentication(
        params,
        successCallback: didFinishedCerificationAction,
      );
    }
  }

  void didFinishedCerificationAction() async {
    ProductDetailModel? model = await NetworkApi.fetchRecommendProduct();
    if (model == null || model.productName.trim().isEmpty) {
      Get.offAllNamed(AppRoutes.Home);
    } else {
      Get.offNamedUntil(
        AppRoutes.ProductDetail,
        (route) => route.isFirst,
        arguments: {'isRecommond': true, 'product': model},
      );
    }
  }
}

class InputControllerModel {
  TextEditingController relationController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
}
