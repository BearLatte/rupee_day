// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/auth_third_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/widget/contact_item_widget.dart';
import 'package:rupee_day/widget/hidden_keyboard_wraper.dart';

class StepThridView extends StatelessWidget {
  const StepThridView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthThirdController controller = Get.find<AuthThirdController>();
    return HiddenKeyboardWrapper(
      child: CommonView(
        title: 'My authentication',
        isShowStep: true,
        totalStep: '3',
        currentStep: '3',
        isDarkStatusBar: false,
        appBarColor: HexColor('#15173B'),
        appBarBottom: PreferredSize(
          preferredSize: const Size(0, 85),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20.0),
            child: Text(
              'The richer the information, the easier to obtain loans.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor('#E09754'),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                    height: 44,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      ),
                      onPressed: controller.addContact,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonImage(src: 'asset/icons/contact_add_icon.png'),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(
                            'Add contact',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ...List.generate(
                    controller.inputControllers.value.length,
                    (index) {
                      return ContactItemWidget(
                        isPhoneEnable: controller.isEnableInput.value,
                        controllerModel: controller.inputControllers.value[index],
                        relationSelectionAction: () => controller.selectRelationAction(index),
                        phoneSelectionAction: () => controller.selectPhoneNumberAction(index),
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                    child: CommonTextButton(
                      'Submit',
                      width: 265,
                      height: 50,
                      borderRadius: 25,
                      backgroundColor: HexColor('#15173B'),
                      onTap: controller.onSubmit,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
