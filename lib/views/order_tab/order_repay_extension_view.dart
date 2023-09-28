import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/repay_extension_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/hex_color.dart';

class OrderRepayExtensionView extends StatelessWidget {
  const OrderRepayExtensionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RepayExtensionController>();
    controller.orderNumber = Get.arguments;
    return FocusDetector(
      onForegroundGained: () => Get.back(),
      child: CommonView(
        title: 'Repay Extension',
        isDarkStatusBar: false,
        child: Stack(
          children: [
            const CommonImage(src: 'asset/images/order_detail_bg_img.png', width: double.infinity, fit: BoxFit.cover),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                    child: Text(
                      'If the deferred fee is paid, it can be repaid later.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: HexColor('#E09754'), fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    decoration: BoxDecoration(color: HexColor('#F6DDB2'), borderRadius: BorderRadius.circular(20)),
                    child: Obx(() {
                      if (controller.extensionDetail.value.productName == null) {
                        return Container();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            controller.extensionDetail.value.productName!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: HexColor('#242431'), fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          _contentRow('Extension Fee', value: '₹ ${controller.extensionDetail.value.extendFee}'),
                          _contentRow('Extension Term', value: '${controller.extensionDetail.value.extendDays} days'),
                          _contentRow('Next Repayment Date', value: controller.extensionDetail.value.loanRepayDate!),
                          _contentRow('Repayment Amount', value: '₹ ${controller.extensionDetail.value.loanRepayAmount}'),
                          Container(
                            margin: const EdgeInsets.only(top: 60, left: 45, right: 45),
                            child: CommonTextButton(
                              'Extension now',
                              width: 1,
                              height: 50,
                              borderRadius: 25,
                              backgroundColor: HexColor('#15173B'),
                              onTap: controller.extensionOnTap,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentRow(String title, {required String value, Color? titleColor, Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16.0, color: titleColor ?? HexColor('#333333'))),
          Text(value, style: TextStyle(color: valueColor ?? HexColor('#15173B'), fontSize: 16)),
        ],
      ),
    );
  }
}
