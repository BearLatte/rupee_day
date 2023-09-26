import 'package:get/get.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/models/order_model.dart';
import 'package:rupee_day/models/space_result_model.dart';
import 'package:rupee_day/views/order_tab/order_type.dart';

class OrderDetailController extends GetxController {
  late String productId;
  var products = [].obs;
  var title = ''.obs;
  var orderType = OrderType.none.obs;
  var isDarkMode = false.obs;
  var tipText = ''.obs;

  // order content
  var productName = ''.obs;
  var loanAmount = ''.obs;
  var applyDate = ''.obs;
  var account = ''.obs;

  @override
  void onReady() {
    super.onReady();
    fetchOrderDetail();
  }

  void fetchOrderDetail() async {
    SpaceResultModel spaceModel = await NetworkApi.checkSpaceDetail(productId);
    OrderModel orderInfo = spaceModel.orderInfo!;
    productName.value = orderInfo.productName;
    products.value = spaceModel.productList ?? [];
    loanAmount.value = '₹ ${orderInfo.loanAmount}';
    applyDate.value = orderInfo.loanApplyDate;
    account.value = orderInfo.bankCardNo ?? '';
    late OrderType type;
    switch (orderInfo.loanStatus) {
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
        break;
      case 4:
        if ((orderInfo.overdueDays ?? 0) > 0) {
          type = OrderType.overdueAndPayed;
        } else {
          type = OrderType.payed;
        }
        title.value = 'Repaid';
        isDarkMode.value = true;
        break;
      case 5:
        if (orderInfo.isPayFail == 1) {
          title.value = 'Disbursing Fail';
          type = OrderType.disbursingFail;
          tipText.value = 'Please confirm if your bank information is correct and reapply.';
        }
        if (orderInfo.isPayFail == 0 && (orderInfo.freezeDays ?? 0) > 0) {
          title.value = 'Denied';
          type = OrderType.denied;
          tipText.value = 'Sorry, your application failed. You can reapply for this product after ${orderInfo.freezeDays} days, or you can apply for other products immediately.';
        }
        if (orderInfo.isPayFail == 0 && orderInfo.freezeDays == 0) {
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
    }
    orderType = type.obs;
  }
}
