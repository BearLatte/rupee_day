import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rupee_day/models/product_model.dart';

class PurchaseSuccessedController extends GetxController {
  void didTapItemWithProduct(ProductModel product) {
    debugPrint('DEBUG: 当前选择的产品$product');
  }
}
