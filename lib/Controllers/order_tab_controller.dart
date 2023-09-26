import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/models/order_list_item_model.dart';

import '../views/order_tab/order_type.dart';

class OrderTabController extends GetxController with GetSingleTickerProviderStateMixin {
  List<Tab> tabs = [
    const Tab(text: 'All orders'),
    const Tab(text: 'Pending'),
    const Tab(text: 'Disbursing'),
    const Tab(text: 'To be Repaid'),
    const Tab(text: 'Disbursing Fail'),
    const Tab(text: 'Overdue'),
    const Tab(text: 'Repaid')
  ];

  List<OrderType> tabBarViewTypes = [
    OrderType.none,
    OrderType.pending,
    OrderType.disbursing,
    OrderType.unpaid,
    OrderType.disbursingFail,
    OrderType.overdue,
    OrderType.payed,
  ];

  RxList<OrderListItemModel> orders = <OrderListItemModel>[].obs;
  late TabController tabController;

  OrderType orderType = OrderType.none;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
