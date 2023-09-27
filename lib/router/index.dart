// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:rupee_day/Controllers/auth_first_controller.dart';
import 'package:rupee_day/Controllers/auth_second_controller.dart';
import 'package:rupee_day/Controllers/auth_third_controller.dart';
import 'package:rupee_day/Controllers/change_bank_card_controller.dart';
import 'package:rupee_day/Controllers/feedback_generate_controller.dart';
import 'package:rupee_day/Controllers/feedback_list_view_controller.dart';
import 'package:rupee_day/Controllers/loan_tab_contaoller.dart';
import 'package:rupee_day/Controllers/login_controller.dart';
import 'package:rupee_day/Controllers/me_controller.dart';
import 'package:rupee_day/Controllers/order_tab_controller.dart';
import 'package:rupee_day/Controllers/product_detail_controller.dart';
import 'package:rupee_day/Controllers/purchase_successed_controller.dart';
import 'package:rupee_day/router/app_routes.dart';
import 'package:rupee_day/views/auth/photo_tips_view.dart';
import 'package:rupee_day/views/auth/step_first_view.dart';
import 'package:rupee_day/views/auth/step_second_view.dart';
import 'package:rupee_day/views/auth/step_thrid_view.dart';
import 'package:rupee_day/views/feedback/feedback_detail_view.dart';
import 'package:rupee_day/views/feedback/feedback_generate_success_view.dart';
import 'package:rupee_day/views/feedback/feedback_generate_view.dart';
import 'package:rupee_day/views/feedback/feedback_list_view.dart';
import 'package:rupee_day/views/home_view.dart';
import 'package:rupee_day/views/login/index.dart';
import 'package:rupee_day/views/login/login_view.dart';
import 'package:rupee_day/views/me_tab/about_us_view.dart';
import 'package:rupee_day/views/me_tab/change_bank_card_view.dart';
import 'package:rupee_day/views/order_tab/order_detail_view.dart';
import 'package:rupee_day/views/order_tab/order_repay_extension_view.dart';
import 'package:rupee_day/views/product/product_detail_view.dart';
import 'package:rupee_day/views/product/purchase_success_view.dart';

class AppPages {
  static const INITIAL = AppRoutes.Home;
  static final routes = [
    GetPage(
      name: AppRoutes.Home,
      page: () => const HomeView(),
      // binding: BindingsBuilder(() => Get.lazyPut(() => LoanTabController())),
      bindings: [
        BindingsBuilder(() => Get.lazyPut(() => LoanTabController())),
        BindingsBuilder(() => Get.lazyPut(() => OrderTabController())),
        BindingsBuilder(() => Get.lazyPut(() => MeController())),
      ],
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.LoginSplash,
      page: () => const LoginSplashView(),
      popGesture: false,
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
    ),
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: AppRoutes.AuthFirst,
      page: () => const StepFirstView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthFirstController())),
      popGesture: false,
    ),
    GetPage(
      name: AppRoutes.PhotoTips,
      page: () => const PhotoTipsView(),
      popGesture: false,
    ),
    GetPage(
      name: AppRoutes.AuthSecond,
      page: () => const StepSecondView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthSecondController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.AuthThird,
      page: () => const StepThridView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthThirdController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.ProductDetail,
      page: () => const ProductDetailView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ProductDetailController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.ProductPurchaseSuccessed,
      page: () => const PurchaseSuccessView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => PurchaseSuccessedController())),
      transition: Transition.cupertino,
    ),
    GetPage(name: AppRoutes.OrderDetail, page: () => OrderDetailView(), transition: Transition.cupertino),
    GetPage(name: AppRoutes.ExtendRepay, page: () => const OrderRepayExtensionView(), transition: Transition.cupertino),
    GetPage(
      name: AppRoutes.FeedbackList,
      page: () => FeedbackListView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => FeedbackListViewController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.ChangeBankCard,
      page: () => const ChangeBankCardView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ChangeBankCardController())),
      transition: Transition.cupertino,
    ),
    GetPage(name: AppRoutes.AboutUs, page: () => const AboutUsView(), transition: Transition.cupertino),
    GetPage(name: AppRoutes.FeedbackGenerateSuccess, page: () => const FeedbackGenerateSuccessView(), transition: Transition.cupertino),
    GetPage(name: AppRoutes.FeedbackDetail, page: () => const FeedbackDetailView(), transition: Transition.cupertino),
    GetPage(
      name: AppRoutes.FeedbackGenerate,
      page: () => const FeedbackGenerateView(),
      transition: Transition.cupertino,
      binding: BindingsBuilder(() => Get.lazyPut(() => FeedbackGenerateController())),
    )
  ];
}
