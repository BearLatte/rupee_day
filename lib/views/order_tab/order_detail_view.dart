import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/order_detail_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/models/product_model.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/views/Product/product_list_item_view.dart';
import 'package:rupee_day/views/order_tab/order_type.dart';

class OrderDetailView extends StatelessWidget {
  OrderDetailView({super.key});

  // final controller = Get.put(OrderDetailController(), tag: RandomUtil.generateRandomString(5));
  final controller = Get.find<OrderDetailController>();

  @override
  Widget build(BuildContext context) {
    controller.orderNo = Get.arguments;
    return Obx(
      () => CommonView(
        title: controller.title.value,
        titleColor: controller.titleColor.value,
        backColor: controller.titleColor.value,
        isDarkStatusBar: controller.isDarkMode.value,
        child: controller.orderType.value == OrderType.none ? Container() : (controller.isDarkMode.value ? darkModeContentView() : bannerContentView()),
      ),
    );
  }

  Widget darkModeContentView() {
    if (controller.orderType.value == OrderType.payed || controller.orderType.value == OrderType.overdueAndPayed) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    Text(controller.orderInfo.value.productName, style: TextStyle(color: HexColor('#333333'), fontSize: 20, fontWeight: FontWeight.w600)),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    _contentRow('Order Number', value: controller.orderInfo.value.loanOrderNo, titleColor: HexColor('#999999')),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    _contentRow('Loan Amount', value: '₹ ${controller.orderInfo.value.loanAmount}', titleColor: HexColor('#999999')),
                    _contentRow('Apply date', value: controller.orderInfo.value.loanApplyDate, titleColor: HexColor('#999999'), valueColor: HexColor('#999999')),
                    _contentRow('Received Amount', value: '₹ ${controller.orderInfo.value.loanPayAmount}', titleColor: HexColor('#999999')),
                    _contentRow('Date of loan received', value: controller.orderInfo.value.loanPayDate!, titleColor: HexColor('#999999'), valueColor: HexColor('#999999')),
                    _contentRow('Repayment Amount', value: '₹ ${controller.orderInfo.value.loanRepayAmount}', titleColor: HexColor('#999999')),
                    _contentRow('Repayment Date', value: controller.orderInfo.value.loanRepayDate!, titleColor: HexColor('#999999'), valueColor: HexColor('#999999')),
                    if (controller.orderType.value == OrderType.overdueAndPayed) _contentRow('Overdue Charge', value: '₹ ${controller.orderInfo.value.overdueAmount}', titleColor: HexColor('#999999')),
                    if (controller.orderType.value == OrderType.overdueAndPayed)
                      _contentRow('Overdue Days', value: '${controller.orderInfo.value.overdueDays}', titleColor: HexColor('#999999'), valueColor: HexColor('#999999')),
                  ],
                ),
              ),
              ...(controller.products.value as List<ProductModel>).map(
                (product) => ProductListItemView(product: product, onTap: () => controller.productItemOnTap(product)),
              )
            ],
          ),
        ),
      );
    } else {
      return FocusDetector(
        onForegroundGained: controller.fetchOrderDetail,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  controller.orderInfo.value.productName,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: HexColor('#333333'), fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Padding(padding: EdgeInsets.only(top: 16)),
                _contentRow('Order Number', value: controller.orderInfo.value.loanOrderNo, titleColor: HexColor('#999999')),
                const Padding(padding: EdgeInsets.only(top: 10)),
                _contentRow('Loan Amount', value: '₹ ${controller.orderInfo.value.loanAmount}', titleColor: HexColor('#999999')),
                _contentRow('Apply date', value: controller.orderInfo.value.loanApplyDate, titleColor: HexColor('#999999')),
                _contentRow('Received Amount', value: '₹ ${controller.orderInfo.value.loanPayAmount}', titleColor: HexColor('#999999')),
                _contentRow('Date of loan received', value: controller.orderInfo.value.loanPayDate!, titleColor: HexColor('#999999')),
                _contentRow('Repayment Amount', value: '₹ ${controller.orderInfo.value.loanRepayAmount}', titleColor: HexColor('#999999')),
                _contentRow('Repayment Date', value: controller.orderInfo.value.loanRepayDate!, titleColor: HexColor('#999999')),
                if (controller.orderType.value == OrderType.overdue)
                  _contentRow(
                    'Overdue Charge',
                    value: '₹ ${controller.orderInfo.value.overdueAmount}',
                    titleColor: HexColor('#999999'),
                  ),
                if (controller.orderType.value == OrderType.overdue)
                  _contentRow(
                    'Overdue Days',
                    value: '${controller.orderInfo.value.overdueDays}',
                    titleColor: HexColor('#999999'),
                  ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                  child: CommonTextButton('Repay Now', width: 1, height: 50, borderRadius: 25, backgroundColor: HexColor('#15173B'), onTap: controller.repayOnTap),
                ),
                if (controller.orderInfo.value?.extendButton == 1)
                  Container(
                    padding: const EdgeInsets.fromLTRB(45, 20, 45, 0),
                    child: CommonTextButton('Repay Extension', width: 0, height: 50, borderRadius: 25, onTap: controller.repayExtensionOnTap),
                  )
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget bannerContentView() {
    return Stack(
      children: [
        CommonImage(
          src: 'asset/images/order_detail_bg_img.png',
          width: MediaQuery.of(Get.context!).size.width,
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, controller.orderType.value != OrderType.throughFrozen ? 80 : 20),
                    child: Text(
                      controller.tipText.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: /*HexColor('#E09754')*/ Colors.transparent,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(child: Container(color: HexColor('#f2f2f2')))
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                        controller.tipText.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: HexColor('#E09754'), fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (controller.orderType.value != OrderType.throughFrozen)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: HexColor('#F6DDB2'), borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              controller.orderInfo.value?.productName ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: HexColor('#242431'), fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            _contentRow('Loan amount', value: '₹ ${controller.orderInfo.value?.loanAmount}'),
                            _contentRow('Apply date', value: controller.orderInfo.value?.loanApplyDate ?? ''),
                            _contentRow('Account', value: controller.orderInfo.value?.bankCardNo ?? ''),
                          ],
                        ),
                      ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    if (controller.orderType.value != OrderType.disbursingFail)
                      ...(controller.products.value as List<ProductModel>).map(
                        (product) => ProductListItemView(product: product, onTap: () => controller.productItemOnTap(product)),
                      )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
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
