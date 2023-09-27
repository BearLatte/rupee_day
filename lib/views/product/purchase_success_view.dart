import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Controllers/purchase_successed_controller.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_view.dart';
import 'package:rupee_day/models/product_model.dart';
import 'package:rupee_day/util/hex_color.dart';
import 'package:rupee_day/views/Product/product_list_item_view.dart';

class PurchaseSuccessView extends StatelessWidget {
  const PurchaseSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = Get.arguments;
    PurchaseSuccessedController controller = Get.find<PurchaseSuccessedController>();
    return CommonView(
      backColor: HexColor('#333333'),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: const CommonImage(src: 'asset/icons/successed_icon.png'),
              ),
              Text(
                'You have successfully applied!',
                style: TextStyle(
                  color: HexColor('#333333'),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: HexColor('#E7AF74'),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'You can also continue to apply for other products now.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor('#333333'),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...products.map(
                (product) => ProductListItemView(
                  product: product,
                  onTap: () => controller.didTapItemWithProduct(product),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
