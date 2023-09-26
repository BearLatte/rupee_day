import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_day/common/common_alert.dart';
import 'package:rupee_day/common/common_snackbar.dart';
import 'package:rupee_day/models/auth_info_model.dart';
import 'package:rupee_day/models/auth_params_model.dart';
import 'package:rupee_day/models/optical_character_model.dart';
import 'package:rupee_day/network/index.dart';
import 'package:rupee_day/router/app_routes.dart';

enum OCRType { front, back, pan }

enum FormItemType {
  aadhaarNumber,
  aadhaarName,
  birth,
  address,
  panCardNumber,
  whatsApp,
  marriage,
  education,
  salary,
  industry,
  workTitle,
  email,
  facebook,
  bankNumber,
  bankName,
  bankIfsc
}

enum Gender { none, male, female }

class AuthFirstController extends GetxController {
  AuthInfoModel? authInfo;
  var panImg = 'asset/images/pan_card_simple_img.png'.obs;
  var kycBackImg = 'asset/images/kyc_back_simple_img.png'.obs;
  var kycFrontImg = 'asset/images/kyc_simple_img.png'.obs;

  String? frontImgPath;
  String? backImgPath;
  String? panImgPath;

  TextEditingController numController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController panNumController = TextEditingController();

  var gender = Gender.none.obs;

  @override
  void onReady() {
    super.onReady();
    fetchAuthModel();
  }

  @override
  void onClose() {
    numController.dispose();
    nameController.dispose();
    birthController.dispose();
    addressController.dispose();
    panNumController.dispose();
    super.onClose();
  }

  void fetchAuthModel() async {
    AuthInfoModel info = await NetworkApi.fetchAuthInfo();
    authInfo = info;
    if (info.frontImage.isNotEmpty) {
      kycFrontImg.value = '${info.imageHttp}/${info.frontImage}';
      frontImgPath = info.frontImage;
    } else {
      kycFrontImg.value = 'asset/images/kyc_simple_img.png';
    }

    if (info.backImage.isNotEmpty) {
      kycBackImg.value = '${info.imageHttp}/${info.frontImage}';
      backImgPath = info.backImage;
    } else {
      kycBackImg.value = 'asset/images/kyc_back_simple_img.png';
    }

    if (info.panCardImg.isNotEmpty) {
      panImg.value = '${info.imageHttp}/${info.frontImage}';
      panImgPath = info.panCardImg;
    } else {
      panImg.value = 'asset/images/pan_card_simple_img.png';
    }
    numController.text = info.aadhaarNumber;
    nameController.text = info.userNames;
    gender.value = info.userGender == 'male' ? Gender.male : Gender.female;
    birthController.text = info.dateOfBirth;
    addressController.text = info.addressDetail;
    panNumController.text = info.panNumber;
  }

  void ocrImageChooseAction(OCRType type) async {
    PermissionStatus status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      CommonSnackbar.showSnackbar(
          'You did not allow us to access the camera, which will help you obtain a loan. Would you like to set up authorization.');
      return;
    }

    if (type == OCRType.front) {
      var result = await Get.toNamed(AppRoutes.PhotoTips);
      if (result != 'ok') return;
    }

    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.camera);

    if (file != null) {
      OpticalCharacterModel model =
          await NetworkApi.opticalCharacterRecognition(file.path, type: type);
      switch (type) {
        case OCRType.front:
          frontImgPath = model.imagePath;
          kycFrontImg.value = '${model.imageHttp}/${model.imagePath}';
          numController.text = model.aadhaarNumber!;
          nameController.text = model.userNames!;
          gender.value =
              model.userGender == 'male' ? Gender.male : Gender.female;
          birthController.text = model.dateOfBirth!;
        case OCRType.back:
          backImgPath = model.imagePath;
          kycBackImg.value = '${model.imageHttp}/${model.imagePath}';
          addressController.text = model.addressDetail!;
        case OCRType.pan:
          panImgPath = model.imagePath;
          panImg.value = '${model.imageHttp}/${model.imagePath}';
          panNumController.text = model.panNumber!;
      }
    }
  }

  void formItemOnTap(FormItemType type) {
    switch (type) {
      case FormItemType.birth:
        chooseDateAction();
      default:
        break;
    }
    debugPrint('DEBUG: 点击响应 $type');
  }

  void chooseDateAction() async {
    DateTime? pickedDate = await DatePicker.showSimpleDatePicker(
      Get.context!,
      initialDate: DateTime(2005),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      dateFormat: 'dd-MM-yyyy',
    );
    if (pickedDate != null) {
      birthController.text =
          formatDate(pickedDate, ['dd', '-', 'mm', '-', 'yyyy']);
    }
  }

  void onNext() async {
    if (frontImgPath == null) {
      CommonSnackbar.showSnackbar(
        'Aadhaar Front can not be empty.',
        type: SnackType.info,
      );
      return;
    }

    if (numController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Aadhaar Number can not be empty.',
        type: SnackType.info,
      );
      return;
    }

    if (nameController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Aadhaar Name can not be empty.',
        type: SnackType.info,
      );
      return;
    }

    if (gender.value == Gender.none) {
      CommonSnackbar.showSnackbar(
        'Please choose your gender.',
        type: SnackType.info,
      );
      return;
    }

    if (birthController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please select your date of birth.',
        type: SnackType.info,
      );
      return;
    }

    if (backImgPath == null) {
      CommonSnackbar.showSnackbar(
        'Aadhaar Back can not be empty.',
        type: SnackType.info,
      );
      return;
    }

    if (addressController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter your detail address.',
        type: SnackType.info,
      );
      return;
    }

    if (panImgPath == null) {
      CommonSnackbar.showSnackbar(
        'Pan card can not be empty.',
        type: SnackType.info,
      );
      return;
    }

    if (panNumController.text.trim().isEmpty) {
      CommonSnackbar.showSnackbar(
        'Please enter your pan card number.',
        type: SnackType.info,
      );
      return;
    }

    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
    } else {
      var result = await CommonAlert.showAlert(
        message:
            'This feature requires you to authorize this app to open the location service\nHow to set it: open phone Settings -> Privacy -> Location service',
      );
      if (result == 'confirm') {
        openAppSettings();
      }
      return;
    }

    AuthParamsModel model = AuthParamsModel(
      authStep: '1',
      frontImage: frontImgPath,
      backImage: backImgPath,
      panCardImg: panImgPath,
      userNames: nameController.text,
      userGender: gender.value == Gender.male ? 'male' : 'female',
      dateOfBirth: birthController.text,
      aadhaarNumber: numController.text,
      addressDetail: addressController.text,
      panNumber: panNumController.text,
    );

    NetworkApi.authentication(model,
        successCallback: () => Get.toNamed(AppRoutes.AuthSecond));
  }
}
