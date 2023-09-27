import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/models/order_model.dart';
import 'package:rupee_day/models/product_model.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/views/order_tab/order_type.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/order_detail_result_model.dart';
import '../models/space_result_model.dart';
import '../router/app_routes.dart';

class OrderDetailController extends GetxController {
  late String orderNo;
  var products = [].obs;
  late Rx<OrderModel> orderInfo;
  var title = ''.obs;
  var orderType = OrderType.none.obs;
  var isDarkMode = false.obs;
  var tipText = ''.obs;
  var titleColor = Colors.white.obs;
  var isShowExtensionButton = true.obs;

  @override
  void onReady() {
    super.onReady();
    fetchOrderDetail();
  }

  void fetchOrderDetail() async {
    OrderDetailResultModel resultModel = await NetworkApi.fetchOrderDetail(orderNo);
    products.value = resultModel.productList ?? [];
    orderInfo = resultModel.orderInfo.obs;
    late OrderType type;
    switch (orderInfo.value!.loanStatus) {
      case 1:
        type = OrderType.pending;
        title.value = 'Pending';
        isDarkMode.value = false;
        tipText.value = 'The loan you submitted is under review. We will notify you after approval.';
        break;
      case 2:
        type = OrderType.disbursing;
        title.value = 'Disbursing';
        isDarkMode.value = false;
        tipText.value = 'The loan you applied for is in the process of lending. We will inform you when it is completed.';
        break;
      case 3:
        type = OrderType.unpaid;
        title.value = 'To be Repaid';
        isDarkMode.value = true;
        titleColor.value = HexColor('#333333');
        break;
      case 4:
        if ((orderInfo.value!.overdueDays ?? 0) > 0) {
          type = OrderType.overdueAndPayed;
        } else {
          type = OrderType.payed;
        }
        title.value = 'Repaid';
        isDarkMode.value = true;
        titleColor.value = HexColor('#333333');
        break;
      case 5:
        if (orderInfo.value!.isPayFail == 1) {
          title.value = 'Disbursing Fail';
          type = OrderType.disbursingFail;
          tipText.value = 'Please confirm if your bank information is correct and reapply.';
        }
        if (orderInfo.value!.isPayFail == 0 && (orderInfo.value!.freezeDays ?? 0) > 0) {
          title.value = 'Denied';
          type = OrderType.denied;
          tipText.value = 'Sorry, your application failed. You can reapply for this product after ${orderInfo.value!.freezeDays} days, or you can apply for other products immediately.';
        }
        if (orderInfo.value!.isPayFail == 0 && orderInfo.value!.freezeDays == 0) {
          title.value = 'Detail';
          type = OrderType.throughFrozen;
          tipText.value = 'Congratulations! Now you can apply for the following loan';
        }
        isDarkMode.value = false;
        break;
      case 6:
        title.value = 'Overdue';
        type = OrderType.overdue;
        isDarkMode.value = true;
        titleColor.value = HexColor('#333333');
    }
    orderType = type.obs;
  }

  void repayOnTap() async {
    Map<String, dynamic> pathModel = await NetworkApi.fetchRepayPath(orderNumber: orderInfo.value.loanOrderNo, loanRepayDate: orderInfo.value.loanRepayDate!);
    if (await canLaunchUrlString(pathModel['rlkepwsayPath'])) {
      await launchUrlString(
        pathModel['rlkepwsayPath'],
        mode: pathModel['wlkebwsviewType'] == 1 ? LaunchMode.inAppWebView : LaunchMode.externalApplication,
      );
    }
  }

  void repayExtensionOnTap() {}

  void productItemOnTap(ProductModel product) async {
    SpaceResultModel model = await NetworkApi.checkSpaceDetail('${product.productId}');
    if (model.spaceStatus == 2) {
      Get.toNamed(AppRoutes.ProductDetail, arguments: {'isRecommond': false, 'product': model.loanProduct});
    }
    if (model.spaceStatus == 3) {
      Get.toNamed(AppRoutes.OrderDetail, arguments: model.orderInfo!.loanOrderNo, preventDuplicates: false);
    }
  }
}
