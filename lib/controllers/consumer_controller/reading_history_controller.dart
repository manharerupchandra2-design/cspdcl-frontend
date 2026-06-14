import 'package:get/get.dart';

import '../../models/consumer_detail_model/reading_history_model.dart';
import '../../services/api_services.dart';

// class HistoryController extends GetxController {
//   RxBool isLoading = false.obs;
//
//   RxList<HistoryItem> history = <HistoryItem>[].obs;
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     getHistory();
//   }
//
//   Future<void> getHistory() async {
//     try {
//       isLoading.value = true;
//
//       history.value = await ApiServices.getHistory();
//
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

class HistoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<HistoryItem> history = <HistoryItem>[].obs;
  RxList<HistoryItem> filteredHistory = <HistoryItem>[].obs; // ← add karo
  Rxn<DateTime> selectedDate = Rxn<DateTime>(); // ← add karo

  @override
  void onInit() {
    super.onInit();
    selectedDate.value=DateTime.now();
    getHistory();
  }

  Future<void> getHistory() async {
    try {
      isLoading.value = true;
      history.value = await ApiServices.getHistory();
      applyFilter();
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    if (selectedDate.value == null) {
      filteredHistory.value = history;
      return;
    }
    filteredHistory.value = history.where((item) {
      try {
        final date = DateTime.parse(item.createdAt);
        final selected = selectedDate.value!;
        return date.year == selected.year &&
            date.month == selected.month &&
            date.day == selected.day;
      } catch (e) {
        print('Date parse error: ${item.createdAt}'); // ← exact format dikhega
        return false;
      }
    }).toList();
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    applyFilter();
  }

  void clearFilter() {
    selectedDate.value = null;
    applyFilter();
  }
}
