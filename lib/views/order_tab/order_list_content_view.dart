import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/order_list_content_controller.dart';
import 'package:rupee_day/models/order_list_item_model.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../../common/common_image.dart';
import '../../common/common_text_button.dart';
import '../../util/hex_color.dart';
import 'order_type.dart';

class OrderListContentView extends StatelessWidget {
  final OrderType type;

  const OrderListContentView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderListContentController(), tag: type.toString());
    controller.orderType = type;
    return FocusDetector(
      onFocusGained: () => controller.fetchOrderList(),
      child: Obx(() {
        if (controller.orders.value.isEmpty) {
          return Column(
            children: <Widget>[
              const Spacer(),
              const CommonImage(src: 'asset/images/order_empty_bg_img.png'),
              Container(
                padding: const EdgeInsets.only(top: 30, left: 65, right: 65),
                child: Text(
                  'You don\'t have a loan yetJust  loan right now!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: HexColor('#15173B'), fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
            ],
          );
        } else {
          return SwipeRefresh.cupertino(
            stateStream: controller.stream,
            onRefresh: controller.fetchOrderList,
            children: controller.orders.value
                .map(
                  (order) => orderItem(
                    order,
                    addFeedbackAction: controller.addFeedbackAction,
                    onTap: () => controller.itemOnTap(order),
                  ),
                )
                .toList(),
          );
        }
      }),
    );
  }

  Widget orderItem(OrderListItemModel order, {required Function(OrderListItemModel order) addFeedbackAction, required Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      title: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(right: 12)),
                ClipOval(child: CommonImage(src: order.productLogo, width: 26)),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Text(order.productName, style: TextStyle(color: HexColor('#242431'), fontSize: 20, fontWeight: FontWeight.w600)),
                const Spacer(),
                Text(order.typeText, style: TextStyle(color: order.typeColor, fontSize: 18)),
                const Padding(padding: EdgeInsets.only(left: 12)),
              ],
            ),
            const Divider(),
            Row(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(left: 22)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('₹ ${order.loanAmount}', style: TextStyle(color: HexColor('#E7AF74'), fontSize: 22, fontWeight: FontWeight.w600)),
                    Text('Loan amount', style: TextStyle(color: HexColor('#999999'), fontSize: 16))
                  ],
                ),
                const Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('₹ ${order.loanApplyDate}', style: TextStyle(color: HexColor('#15173B'), fontSize: 22, fontWeight: FontWeight.w600)),
                  Text('Loan Date', style: TextStyle(color: HexColor('#999999'), fontSize: 16))
                ]),
                const Padding(padding: EdgeInsets.only(right: 22)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Text('Order Number : ${order.loanOrderNo}', textAlign: TextAlign.left, style: TextStyle(color: HexColor('#15173B'), fontSize: 16)),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            CommonTextButton('Feedback', width: 185, height: 40, borderRadius: 20, backgroundColor: HexColor('#15173B'), onTap: () => addFeedbackAction(order))
          ],
        ),
      ),
    );
  }
}
