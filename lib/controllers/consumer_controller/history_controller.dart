import 'package:get/get.dart';

import '../../models/consumer_detail_model/history_model.dart';
import '../../services/api_services.dart';

class HistoryController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<HistoryItem> history =
      <HistoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getHistory();
  }

  Future<void> getHistory() async {
    try {
      isLoading.value = true;

      history.value =
      await ApiServices.getHistory();
    } finally {
      isLoading.value = false;
    }
  }
}