import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/feedback_list_view_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/models/feedback_model.dart';
import 'package:rupee_day/util/hex_corlor.dart';

class FeedbackListView extends StatelessWidget {
  FeedbackListView({super.key});

  final controller = Get.find<FeedbackListViewController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'My feedback',
      appBarColor: HexColor('#15173B'),
      isDarkStatusBar: false,
      child: SafeArea(child: Obx(() {
        if (controller.feedbackList.value.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const CommonImage(src: 'asset/images/feedback_placeholder.png', fit: BoxFit.fill),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Please tell us your problems. We will solve in time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: HexColor('#15173B'), fontSize: 16),
                ),
              )
            ],
          );
        }
        return ListView.builder(
          itemCount: controller.feedbackList.value.length,
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (BuildContext context, int index) {
            FeedbackModel feedback = controller.feedbackList.value[index];
            return ListTile(
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        feedback.feedBackType,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: HexColor('#E09754'), fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Divider(height: 1, color: HexColor('#E9E9E9')),
                    Row(
                      children: [
                        Text(
                          feedback.productName,
                          style: TextStyle(color: HexColor('#333333'), fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        if (feedback.feedBackState == 1)
                          Container(
                            decoration:
                                BoxDecoration(color: HexColor('#E09754'), borderRadius: BorderRadius.circular(10)),
                            child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ),
                        Text(feedback.feedBackTime, style: TextStyle(color: HexColor('#D0D0D0'), fontSize: 14))
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Order Number : ${feedback.loanOrderNo}'),
                    )
                  ],
                ),
              ),
            );
          },
        );
      })),
    );
  }
}
