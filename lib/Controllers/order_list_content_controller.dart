import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rupee_day/models/order_list_item_model.dart';
import 'package:rupee_day/views/order_tab/order_type.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../Network/index.dart';
import '../global/index.dart';
import '../models/order_result_list_model.dart';
import '../router/app_routes.dart';

class OrderListContentController extends GetxController {
  OrderType? orderType;
  late OrderResultListModel orderListModel;
  var orders = <OrderListItemModel>[].obs;
  var refreshStatus = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream => refreshStatus.stream;

  @override
  void onReady() async {
    super.onReady();
    await checkLoginState();
  }

  Future checkLoginState() async {
    if (!(await Global.isLogin)) {
      return Get.toNamed(AppRoutes.LoginSplash);
    }
  }

  void fetchOrderList() async {
    if (orderType == null) return;
    orderListModel = await NetworkApi.fetchOrderList(orderType!);
    refreshStatus.sink.add(SwipeRefreshState.hidden);
    orders.value = orderListModel.orderList;
  }

  void addFeedbackAction(OrderListItemModel order) {
    Get.toNamed(AppRoutes.FeedbackGenerate, arguments: {
      'types': orderListModel.feedBackTypes,
      'order': order,
    })?.then((value) => fetchOrderList());
  }

  void itemOnTap(OrderListItemModel order) {
    debugPrint('DEBUG: 选中当前order: ${order.toJson()}');
  }
}
