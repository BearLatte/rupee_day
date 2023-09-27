import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/auth_first_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/widget/form_item_widget.dart';
import 'package:rupee_day/widget/hidden_keyboard_wraper.dart';

class StepFirstView extends StatelessWidget {
  const StepFirstView({super.key});

  Widget ocrChooseBtn({
    required String leftImage,
    required String buttonTitle,
    Function()? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                ),
                child: CommonImage(
                  src: leftImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                width: 125,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor('#15173B'),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    const CommonImage(src: 'asset/icons/auth_camera_icon.png'),
                    const Padding(padding: EdgeInsets.only(bottom: 6.0)),
                    Text(
                      buttonTitle,
                      style: TextStyle(
                        color: HexColor('#E09754'),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget genderItem({
    Gender gender = Gender.none,
    required Function(Gender gender) valueChanged,
  }) {
    return Container(
      height: 44.0,
      margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gender',
            style: TextStyle(color: HexColor('#333333'), fontSize: 14.0),
          ),
          CommonTextButton(
            'male',
            titleColor: gender == Gender.male ? Colors.white : HexColor('#999999'),
            titleSize: 16.0,
            width: 128,
            height: 44,
            borderRadius: 22,
            backgroundColor: gender == Gender.male ? HexColor('#E09754') : Colors.white,
            onTap: () => valueChanged(Gender.male),
          ),
          CommonTextButton(
            'female',
            titleColor: gender == Gender.female ? Colors.white : HexColor('#999999'),
            titleSize: 16.0,
            width: 128,
            height: 44,
            borderRadius: 22,
            backgroundColor: gender == Gender.female ? HexColor('#E09754') : Colors.white,
            onTap: () => valueChanged(Gender.female),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthFirstController>();

    return HiddenKeyboardWrapper(
      child: CommonView(
        title: 'My authentication',
        appBarColor: HexColor('#15173B'),
        isDarkStatusBar: false,
        isShowStep: true,
        appBarBottom: PreferredSize(
          preferredSize: const Size(0, 30.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 20.0)),
                  const CommonImage(src: 'asset/icons/auth_horn_icon.png'),
                  const Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text(
                    'Please upload clear and original documents.',
                    style: TextStyle(color: HexColor('#F6DDB2'), fontSize: 14.0),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 10.0))
            ],
          ),
        ),
        child: ListView(
          children: [
            Obx(
              () => ocrChooseBtn(
                leftImage: controller.kycFrontImg.value,
                buttonTitle: 'Aadhaar Front',
                onTap: () => controller.ocrImageChooseAction(OCRType.front),
              ),
            ),
            FormItemWidget(
              itemName: 'Aadhaar Number',
              inputController: controller.numController,
              placeholder: 'Please enter',
              onTap: () => controller.formItemOnTap(FormItemType.aadhaarNumber),
            ),
            FormItemWidget(
              itemName: 'Aadhaar Name',
              inputController: controller.nameController,
              placeholder: 'Please enter',
              onTap: () => controller.formItemOnTap(FormItemType.aadhaarName),
            ),
            Obx(() => genderItem(
                  gender: controller.gender.value,
                  valueChanged: (gender) => controller.gender.value = gender,
                )),
            FormItemWidget(
              itemName: 'Date of Birth',
              inputController: controller.birthController,
              placeholder: 'Please select',
              onTap: () => controller.formItemOnTap(FormItemType.birth),
              type: ItemType.calendar,
            ),
            Obx(
              () => ocrChooseBtn(
                leftImage: controller.kycBackImg.value,
                buttonTitle: 'Aadhaar Back',
                onTap: () => controller.ocrImageChooseAction(OCRType.back),
              ),
            ),
            FormItemWidget(
              itemName: 'Detail Address',
              inputController: controller.addressController,
              placeholder: 'Please enter',
              multiLines: true,
            ),
            Obx(
              () => ocrChooseBtn(
                leftImage: controller.panImg.value,
                buttonTitle: 'Pan card Front',
                onTap: () => controller.ocrImageChooseAction(OCRType.pan),
              ),
            ),
            FormItemWidget(
              itemName: 'Pan Card Number',
              inputController: controller.panNumController,
              placeholder: 'Please enter',
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 20.0),
              child: CommonTextButton(
                'Next',
                width: 265,
                height: 50,
                borderRadius: 25,
                backgroundColor: HexColor('#15173B'),
                onTap: controller.onNext,
              ),
            )
          ],
        ),
      ),
    );
  }
}
