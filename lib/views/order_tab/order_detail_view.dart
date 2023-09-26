import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/order_detail_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/models/product_model.dart';
import 'package:rupee_day/util/hex_corlor.dart';
import 'package:rupee_day/views/Product/product_list_item_view.dart';
import 'package:rupee_day/views/order_tab/order_type.dart';

class OrderDetailView extends StatelessWidget {
  OrderDetailView({super.key});

  final controller = Get.find<OrderDetailController>();

  @override
  Widget build(BuildContext context) {
    controller.productId = Get.arguments;
    return Obx(
      () => CommonView(
        title: controller.title.value,
        isDarkStatusBar: controller.isDarkMode.value,
        child: controller.orderType.value == OrderType.none
            ? Container()
            : (controller.isDarkMode.value
                ? darkModeContentView()
                : bannerContentView()),
      ),
    );
  }

  Widget darkModeContentView() {
    return Container();
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
                    padding: EdgeInsets.fromLTRB(
                      20,
                      10,
                      20,
                      controller.orderType.value != OrderType.throughFrozen
                          ? 80
                          : 20,
                    ),
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
                        style: TextStyle(
                          color: HexColor('#E09754'),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: HexColor('#F6DDB2'),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            controller.productName.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: HexColor('#242431'),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          _contentRow(
                            'Loan amount',
                            controller.loanAmount.value,
                          ),
                          _contentRow(
                            'Apply date',
                            controller.applyDate.value,
                          ),
                          _contentRow(
                            'Account',
                            controller.account.value,
                          ),
                        ],
                      ),
                    ),
                    // ignore: invalid_use_of_protected_member
                    ...(controller.products.value as List<ProductModel>).map(
                      (product) => ProductListItemView(product: product),
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

  Widget _contentRow(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, color: HexColor('#333333')),
          ),
          Text(
            value,
            style: TextStyle(color: HexColor('#15173B'), fontSize: 16),
          )
        ],
      ),
    );
  }
}
