import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/feedback_generate_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/widget/hidden_keyboard_wraper.dart';
import 'package:rupee_day/widget/image_grid_view.dart';

class FeedbackGenerateView extends StatelessWidget {
  const FeedbackGenerateView({super.key});

  @override
  Widget build(BuildContext context) {
    FeedbackGenerateController controller = Get.find<FeedbackGenerateController>();
    controller.types = Get.arguments['types'];
    var order = Get.arguments['order'];
    controller.order = order;
    return HiddenKeyboardWrapper(
      child: CommonView(
        title: 'Submit feedback',
        isDarkStatusBar: false,
        child: Stack(
          children: [
            const CommonImage(
              src: 'asset/images/order_detail_bg_img.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fill in your question here and we will solve it for you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: HexColor('#E09754'), fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(order.productName, style: TextStyle(color: HexColor('#333333'), fontSize: 20, fontWeight: FontWeight.w600)),
                              const Padding(padding: EdgeInsets.only(bottom: 5)),
                              Text(
                                'Order Number : ${order.loanOrderNo}',
                                style: TextStyle(color: HexColor('#15173B'), fontSize: 16),
                              ),
                              const Padding(padding: EdgeInsets.only(bottom: 20)),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Types of question',
                                  style: TextStyle(color: HexColor('#333333'), fontSize: 14),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: HexColor('#EDEDF4'),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        readOnly: true,
                                        controller: controller.feedbackTypeController,
                                        onTap: controller.showTypesBottomSheet,
                                        style: TextStyle(color: HexColor('#15173B'), fontSize: 16),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Types of question',
                                          hintStyle: TextStyle(color: HexColor('#999999'), fontSize: 16.0),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: controller.showTypesBottomSheet,
                                      child: const CommonImage(src: 'asset/icons/arrow_right_icon.png'),
                                    )
                                  ],
                                ),
                              ),
                              if (controller.currentFeedbackType.value.typeContent != null)
                                Container(
                                  padding: const EdgeInsets.only(top: 4, left: 4),
                                  child: Text(
                                    controller.currentFeedbackType.value.typeContent!,
                                    style: TextStyle(color: HexColor('#999999'), fontSize: 13),
                                  ),
                                ),
                            ],
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      constraints: const BoxConstraints(minHeight: 130),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: controller.feedbackDescController,
                        style: TextStyle(color: HexColor('#15173B'), fontSize: 14),
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Please describe your problem.',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: HexColor('#999999'), fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Upload your pictures to show your problem',
                        style: TextStyle(
                          color: HexColor('#333333'),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ImageGridView(onChanged: (pics) => controller.images = pics),
                    Container(
                      padding: const EdgeInsets.only(top: 50, bottom: 10),
                      alignment: Alignment.center,
                      child: CommonTextButton('Submit', width: 265, height: 50, borderRadius: 25, onTap: controller.onSubmit),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
