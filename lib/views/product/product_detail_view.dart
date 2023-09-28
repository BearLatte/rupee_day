import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/product_detail_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_text_button.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/models/product_detail_model.dart';
import 'package:rupee_day/util/hex_color.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductDetailController controller = Get.find<ProductDetailController>();
    controller.isRecommond = Get.arguments['isRecommond'];
    ProductDetailModel product = Get.arguments['product'];
    controller.productId = '${product.productId}';
    return CommonView(
      title: 'Detail',
      titleColor: HexColor('#333333'),
      backColor: HexColor('#333333'),
      backAction: controller.backAction,
      child: Center(
        child: SafeArea(
          child: Stack(
            children: [
              const CommonImage(src: 'asset/images/product_detail_bg_img.png'),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                  child: Obx(
                    () => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(child: CommonImage(src: product.productLogo, width: 40, height: 40)),
                            const Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              product.productName,
                              style: TextStyle(color: HexColor('#242431'), fontSize: 20.0, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                        _formRow('Amount', '₹ ${product.loanAmount}'),
                        _formRow('Received Amount', '₹ ${product.loanPayAmount}'),
                        _formRow('Terms', '₹ ${product.loanInterest}'),
                        _formRow('Verification Fee', '₹ ${product.loanFeeVerify}'),
                        _formRow('GST', '₹ ${product.loanFeeGst}'),
                        _formRow('Overdue Charge', '₹ ${product.loanOverdue}'),
                        _formRow('Interest', '₹ ${product.loanInterest}'),
                        _formRow('Repayment Amount', '₹ ${product.loanAmount}'),
                        if (controller.isAppleTestAccount.value) _formRow('APR', '18.25%'),
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: CommonTextButton(
                            'Loan now',
                            width: 265,
                            height: 50,
                            borderRadius: 25,
                            backgroundColor: HexColor('#15173B'),
                            onTap: controller.loanBtnAction,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _formRow(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TextStyle(color: HexColor('#999999'), fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(color: HexColor('#E09754'), fontSize: 16),
          )
        ],
      ),
    );
  }
}
