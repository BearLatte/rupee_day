import 'package:get/get.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/models/feedback_model.dart';

class FeedbackListViewController extends GetxController {
  var feedbackList = <FeedbackModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedbacks();
  }

  void fetchFeedbacks() async {
    feedbackList.value = await NetworkApi.fetchFeedbackList();
  }
}
