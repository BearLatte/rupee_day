import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/auth_first_controller.dart';
import 'package:rupee_day/Controllers/auth_second_controller.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/widget/form_item_widget.dart';
import 'package:rupee_day/widget/hidden_keyboard_wraper.dart';

class StepSecondView extends StatelessWidget {
  const StepSecondView({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthSecondController controller = Get.put(AuthSecondController());
    final controller = Get.find<AuthSecondController>();
    return HiddenKeyboardWrapper(
      child: CommonView(
        title: 'My authentication',
        totalStep: '3',
        isShowStep: true,
        currentStep: '2',
        appBarColor: HexColor('#15173B'),
        isDarkStatusBar: false,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                FormItemWidget(
                  itemName: 'WhatsApp Account',
                  inputController: controller.whatAppController,
                  placeholder: 'Please enter',
                  onTap: () => controller.formItemOnTap(FormItemType.whatsApp),
                  keyboardType: TextInputType.number,
                ),
                FormItemWidget(
                  itemName: 'Marriage Status',
                  inputController: controller.marriageController,
                  placeholder: 'Please select',
                  type: ItemType.more,
                  onTap: () => controller.formItemOnTap(FormItemType.marriage),
                ),
                FormItemWidget(
                  itemName: 'Education',
                  inputController: controller.educationController,
                  placeholder: 'Please select',
                  type: ItemType.more,
                  onTap: () => controller.formItemOnTap(FormItemType.education),
                ),
                FormItemWidget(
                  itemName: 'Monthly Salary',
                  inputController: controller.salaryController,
                  placeholder: 'Please select',
                  type: ItemType.more,
                  onTap: () => controller.formItemOnTap(FormItemType.salary),
                ),
                FormItemWidget(
                  itemName: 'Industry',
                  inputController: controller.industryController,
                  placeholder: 'Please select',
                  type: ItemType.more,
                  onTap: () => controller.formItemOnTap(FormItemType.industry),
                ),
                FormItemWidget(
                  itemName: 'Work Title',
                  inputController: controller.workTitleController,
                  placeholder: 'Please select',
                  type: ItemType.more,
                  onTap: () => controller.formItemOnTap(FormItemType.workTitle),
                ),
                FormItemWidget(
                  itemName: 'E-mail',
                  inputController: controller.emailController,
                  placeholder: 'Please enter',
                  onTap: () => controller.formItemOnTap(FormItemType.email),
                ),
                Obx(
                  () => FormItemWidget(
                    itemName: 'Target amount',
                    inputController: controller.targetAmountController,
                    placeholder: '${controller.minAmount} to ${controller.maxAmount}',
                    keyboardType: TextInputType.number,
                  ),
                ),
                FormItemWidget(
                  itemName: 'Facebook ID (optional)',
                  inputController: controller.facebookController,
                  placeholder: 'Please enter',
                  onTap: () => controller.formItemOnTap(FormItemType.facebook),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                  child: Text(
                    'Bank info',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: HexColor('#333333'),
                    ),
                  ),
                ),
                FormItemWidget(
                  itemName: 'Bank Card Number',
                  inputController: controller.bankNumberController,
                  placeholder: 'Please enter',
                  onTap: () => controller.formItemOnTap(FormItemType.bankNumber),
                  keyboardType: TextInputType.number,
                ),
                FormItemWidget(
                  itemName: 'Bank Name',
                  inputController: controller.bankNameController,
                  placeholder: 'Please enter',
                  onTap: () => controller.formItemOnTap(FormItemType.bankName),
                ),
                FormItemWidget(
                  itemName: 'Bank IFSC',
                  inputController: controller.ifscController,
                  placeholder: 'Please enter',
                  onTap: () => controller.formItemOnTap(FormItemType.bankIfsc),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
        ),
      ),
    );
  }
}
