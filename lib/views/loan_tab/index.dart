import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/loan_tab_contaoller.dart';
import 'package:rupee_day/common/common_alert.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/views/Product/product_list_item_view.dart';

class LoanTab extends StatelessWidget {
  const LoanTab({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: GetBuilder<LoanTabController>(builder: (controller) {
        if (controller.userInfo?.userPayFail == 1) {
          CommonAlert.showAlert();
        }
        return Container(
          color: HexColor('#EEEFF5'),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CommonImage(src: controller.isCertified ? 'asset/images/banner_certified.png' : 'asset/images/banner_uncertified.png', fit: BoxFit.fill),
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: controller.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductListItemView(product: controller.products[index], onTap: () => controller.loanBtnOnPressed(index));
                    },
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
