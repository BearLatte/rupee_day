import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/auth_first_controller.dart';
import 'package:rupee_day/common/common_picker.dart';
import 'package:rupee_day/common/common_snackbar.dart';
import 'package:rupee_day/models/auth_info_model.dart';
import 'package:rupee_day/models/auth_params_model.dart';
import 'package:rupee_day/network/index.dart';
import 'package:rupee_day/router/app_routes.dart';
import 'package:rupee_day/util/adjust_track_tool.dart';

class AuthSecondController extends GetxController {
  var minAmount = ''.obs;
  var maxAmount = ''.obs;
  late AuthInfoModel authInfo;
  TextEditingController whatAppController = TextEditingController();
  TextEditingController marriageController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  TextEditingController workTitleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAuthInfo();
  }

  void fetchAuthInfo() async {
    AuthInfoModel info = await NetworkApi.fetchAuthInfo();
    authInfo = info;
    whatAppController.text = info.whatsAppAccount;
    marriageController.text = info.marriageStatus;
    educationController.text = info.education;
    salaryController.text = info.monthlySalary;
    industryController.text = info.userIndustry;
    workTitleController.text = info.workTitle;
    emailController.text = info.userEmail;
    targetAmountController.text = info.applyAmount;
    facebookController.text = info.facebookId;
    bankNumberController.text = info.bankCardNo;
    bankNameController.text = info.bankCardName;
    ifscController.text = info.bankIfscCode;
    minAmount.value = '₹ ${info.amountMin}';
    maxAmount.value = '₹ ${info.amountMax}';
  }

  void formItemOnTap(FormItemType itemType) async {
    debugPrint('DEBUG: $itemType');
    switch (itemType) {
      case FormItemType.marriage:
        ADJustTrackTool.trackWith('snnrse');
        int? selectedIndex = await CommonPicker.showPicker(
          context: Get.context!,
          options: authInfo.marriageStatusList,
          value: 0,
        );

        if (selectedIndex != null) {
          marriageController.text = authInfo.marriageStatusList[selectedIndex];
        }
        break;
      case FormItemType.education:
        ADJustTrackTool.trackWith('q1cokl');
        int? selectedIndex = await CommonPicker.showPicker(
          context: Get.context!,
          options: authInfo.educationList,
          value: 0,
        );
        if (selectedIndex != null) {
          educationController.text = authInfo.educationList[selectedIndex];
        }
      case FormItemType.salary:
        ADJustTrackTool.trackWith('8p5yxb');
        int? selectedIndex = await CommonPicker.showPicker(
          context: Get.context!,
          options: authInfo.monthlySalaryList,
          value: 0,
        );
        if (selectedIndex != null) {
          salaryController.text = authInfo.monthlySalaryList[selectedIndex];
        }
      case FormItemType.industry:
        ADJustTrackTool.trackWith('vlgl8c');
        int? selectedIndex = await CommonPicker.showPicker(
          context: Get.context!,
          options: authInfo.industryList,
          value: 0,
        );
        if (selectedIndex != null) {
          industryController.text = authInfo.industryList[selectedIndex];
        }
      case FormItemType.workTitle:
        ADJustTrackTool.trackWith('pzo772');
        int? selectedIndex = await CommonPicker.showPicker(
          context: Get.context!,
          options: authInfo.workTitleList,
          value: 0,
        );
        if (selectedIndex != null) {
          workTitleController.text = authInfo.workTitleList[selectedIndex];
        }
      case FormItemType.email:
        ADJustTrackTool.trackWith('cms0iq');
        break;
      case FormItemType.bankName:
        ADJustTrackTool.trackWith('fbp72t');
        break;
      case FormItemType.bankNumber:
        ADJustTrackTool.trackWith('sq1kb5');
        break;
      case FormItemType.bankIfsc:
        ADJustTrackTool.trackWith('mf7cu7');
        break;
      default:
        break;
    }
  }

  void onNext() async {
    ADJustTrackTool.trackWith('gbnhhs');
    if (whatAppController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'WhatsApp Account can not be empty!',
        type: SnackType.info,
      );
      return;
    }

    if (marriageController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please slect your marriage status!',
        type: SnackType.info,
      );
      return;
    }

    if (educationController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please slect your education level!',
        type: SnackType.info,
      );
      return;
    }

    if (salaryController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please slect your Monthly Salary!',
        type: SnackType.info,
      );
      return;
    }

    if (industryController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please slect Industry!',
        type: SnackType.info,
      );
      return;
    }

    if (workTitleController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please slect your work title!',
        type: SnackType.info,
      );
      return;
    }

    if (emailController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter your E-mail!',
        type: SnackType.info,
      );
      return;
    }

    if (targetAmountController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter target amount!',
        type: SnackType.info,
      );
      return;
    }

    if (targetAmountController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter target amount!',
        type: SnackType.info,
      );
      return;
    }

    if (int.tryParse(targetAmountController.text) == null) {
      CommonSnackbar.showSnackbar(
        'Please enter correct target amount!',
        type: SnackType.info,
      );
      return;
    }

    if (bankNumberController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter your bank card number!',
        type: SnackType.info,
      );
      return;
    }

    if (bankNameController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter bank name!',
        type: SnackType.info,
      );
      return;
    }

    if (ifscController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter bank IFSC code!',
        type: SnackType.info,
      );
      return;
    }

    if (int.parse(targetAmountController.text) > authInfo.amountMax) {
      CommonSnackbar.showSnackbar(
        'The maximum amount is ${authInfo.amountMax}!',
        type: SnackType.info,
      );
      return;
    }

    AuthParamsModel paramsModel = AuthParamsModel(
      authStep: '2',
      whatsAppAccount: whatAppController.text,
      marriageStatus: marriageController.text,
      education: educationController.text,
      monthlySalary: salaryController.text,
      userIndustry: industryController.text,
      workTitle: workTitleController.text,
      userEmail: emailController.text,
      applyAmount: targetAmountController.text,
      facebookId: facebookController.text.trim().isEmpty ? null : facebookController.text,
      bankCardNo: bankNumberController.text,
      bankCardName: bankNameController.text,
      bankIfscCode: ifscController.text,
    );

    NetworkApi.authentication(
      paramsModel,
      successCallback: () => Get.toNamed(AppRoutes.AuthThird),
    );
  }
}
