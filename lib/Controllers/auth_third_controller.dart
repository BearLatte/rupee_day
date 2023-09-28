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
import 'package:rupee_day/util/adjust_track_tool.dart';

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
    switch (index) {
      case 0:
        ADJustTrackTool.trackWith('l33az0');
        break;
      case 1:
        ADJustTrackTool.trackWith('58esi4');
        break;
      case 2:
        ADJustTrackTool.trackWith('bk11zg');
        break;
      case 3:
        ADJustTrackTool.trackWith('acz759');
        break;
      case 4:
        ADJustTrackTool.trackWith('5c91p4');
        break;
    }
    int? selectedIndex = await CommonPicker.showPicker(
      context: Get.context!,
      value: 0,
      options: authInfo.relationList,
    );

    if (selectedIndex != null) {
      inputControllers[index].relationController.text = authInfo.relationList[selectedIndex];
    }
  }

  void selectPhoneNumberAction(int index) async {
    debugPrint('DEBUG: 选择电话号码，当前选择的索引是$index');
    switch (index) {
      case 0:
        ADJustTrackTool.trackWith('kn8zfw');
        break;
      case 1:
        ADJustTrackTool.trackWith('vyur5d');
        break;
      case 2:
        ADJustTrackTool.trackWith('g0wtbp');
        ADJustTrackTool.trackWith('3u4gx5');
        break;
      case 3:
        ADJustTrackTool.trackWith('7jvd04');
        ADJustTrackTool.trackWith('7spud6');
        break;
      case 4:
        ADJustTrackTool.trackWith('g9dgfh');
        ADJustTrackTool.trackWith('jcu89i');
        break;
    }
    if (isEnableInput.value) return;
    final contact = await FlutterContactPicker().selectContact();
    if (contact == null) return;
    inputControllers[index].contactNameController.text = contact.fullName;
    inputControllers[index].phoneNumberController.text = contact.phoneNumbers?.first;
  }

  void onSubmit() async {
    ADJustTrackTool.trackWith('375u8v');
    List<Map<String, String>> contacts = [];
    for (InputControllerModel controllerModel in inputControllers.value) {
      if (controllerModel.relationController.text.trim().isEmpty || controllerModel.phoneNumberController.text.trim().isEmpty || controllerModel.contactNameController.text.trim().isEmpty) {
        CommonSnackbar.showSnackbar('Please complete each item in the list!');
        return;
      }
      contacts.add({'contactName': controllerModel.contactNameController.text, 'contactPhone': controllerModel.phoneNumberController.text, 'contactRelation': controllerModel.relationController.text});
    }

    String result = await CommonAlert.showAlert(
      style: AlertStyle.tips,
      message: 'After the information is submitted, you can only change the bank information. So please make sure that other information is correct.',
    );

    if (result == 'confirm') {
      AuthParamsModel params = AuthParamsModel(authStep: '3', contactList: jsonEncode(contacts));
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
