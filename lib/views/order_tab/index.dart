import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/order_tab_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/util/colors_util.dart';
import 'package:rupee_day/util/hex_corlor.dart';
import 'package:rupee_day/views/order_tab/order_list_content_view.dart';

class OrderTab extends StatelessWidget {
  OrderTab({super.key});
  final controller = Get.find<OrderTabController>();
  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'My orders',
      isDarkStatusBar: false,
      isShowBackBtn: false,
      child: Stack(
        children: [
          CommonImage(src: 'asset/images/order_detail_bg_img.png', width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
          SafeArea(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 45),
                    child: const Text(
                      'You can apply for a higher amount if you can pay off the loan on time.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.transparent, fontSize: 18, fontWeight: FontWeight.w600),
                    )),
                Expanded(child: Container(color: HexColor('#f2f2f2')))
              ],
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Text(
                    'You can apply for a higher amount if you can pay off the loan on time.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: HexColor('#E09754'), fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  decoration: BoxDecoration(color: HexColor('#E09754'), borderRadius: BorderRadius.circular(10)),
                  child: TabBar(
                    controller: controller.tabController,
                    tabs: controller.tabs,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.only(left: 12),
                    labelColor: ColorsUtil.hexColor(0x333333),
                    labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    unselectedLabelColor: ColorsUtil.hexColor(0x333333, alpha: 0.3),
                    unselectedLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    indicator: const BoxDecoration(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: List.generate(
                      controller.tabs.length,
                      (index) => OrderListContentView(type: controller.tabBarViewTypes[index]),
                    ).toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
