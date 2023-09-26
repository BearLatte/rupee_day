import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/global/index.dart';
import 'package:rupee_day/models/product_model.dart';
import 'package:rupee_day/models/space_result_model.dart';
import 'package:rupee_day/models/user_info_model.dart';
import 'package:rupee_day/router/app_routes.dart';

class LoanTabController extends GetxController with RouteAware {
  UserInfoModel? userInfo;
  bool isCertified = false;
  List<ProductModel> products = [];

  bool _isNetworkChecked = false;

  @override
  void onInit() {
    getProducts();
    initConnectivity();
    super.onInit();
  }

  void initConnectivity() async {
    Connectivity().onConnectivityChanged.listen((event) {
      if (!_isNetworkChecked) {
        if (event != ConnectivityResult.none) {
          getProducts();
          _isNetworkChecked = true;
        }
      }
    });
  }

  void getProducts() async {
    if (await Global.isLogin) {
      userInfo = await NetworkApi.fetchUserInfo();
      isCertified = userInfo?.userStatus == 2;
      products = userInfo?.productList ?? [];
    } else {
      products = await NetworkApi.fetchUnLoginProducts();
    }
    update();
  }

  void loanBtnOnPressed(int index) async {
    if (await Global.isLogin) {
      if (!isCertified) {
        Get.toNamed(AppRoutes.AuthFirst)?.then((value) => getProducts());
      } else {
        ProductModel product = products[index];
        SpaceResultModel model =
            await NetworkApi.checkSpaceDetail('${product.productId}');
        if (model.spaceStatus == 2) {
          Get.toNamed(
            AppRoutes.ProductDetail,
            arguments: {'isRecommond': false, 'product': model.loanProduct},
          );
        }
        if (model.spaceStatus == 3) {
          Get.toNamed(AppRoutes.OrderDetail, arguments: '${product.productId}');
        }
      }
    } else {
      Get.toNamed(AppRoutes.LoginSplash)?.then((value) => getProducts());
    }
  }
}
