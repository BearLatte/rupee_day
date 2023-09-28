import 'package:get/get.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/models/repay_extension_model.dart';
import 'package:rupee_day/util/adjust_track_tool.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../views/order_tab/order_type.dart';

class RepayExtensionController extends GetxController {
  late String orderNumber;
  late OrderType orderType;
  Rx<RepayExtensionModel> extensionDetail = RepayExtensionModel.fromJson({}).obs;

  @override
  void onReady() {
    super.onReady();
    fetchExtensionModel();
  }

  void fetchExtensionModel() async {
    extensionDetail.value = await NetworkApi.fetchRepayExtensionDetail(orderNumber);
  }

  void extensionOnTap() async {
    if (orderType == OrderType.overdue) {
      ADJustTrackTool.trackWith('bdg92m');
    }
    Map<String, dynamic> pathModel = await NetworkApi.fetchRepayPath(orderNumber: orderNumber, loanRepayDate: extensionDetail.value.extendRepayDate!);
    if (await canLaunchUrlString(pathModel['rlkepwsayPath'])) {
      await launchUrlString(
        pathModel['rlkepwsayPath'],
        mode: pathModel['wlkebwsviewType'] == 1 ? LaunchMode.inAppWebView : LaunchMode.externalApplication,
      );
    }
  }
}
