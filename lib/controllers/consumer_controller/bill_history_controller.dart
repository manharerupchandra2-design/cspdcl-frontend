import 'package:get/get.dart';

import '../../models/consumer_detail_model/bil_history_model.dart';
import '../../services/api_services.dart';

class BillHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<BillHistoryItem> bills = <BillHistoryItem>[].obs;
  RxList<BillHistoryItem> filteredBills = <BillHistoryItem>[].obs;
  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    selectedDate.value = DateTime.now();
    getBillHistory();
  }

  Future<void> getBillHistory() async {
    try {
      isLoading.value = true;
      bills.value = await ApiServices.getBillHistory();
      applyFilter();
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    if (selectedDate.value == null) {
      filteredBills.value = bills;
      return;
    }
    filteredBills.value = bills.where((item) {
      final date = DateTime.parse(item.createdAt);
      final selected = selectedDate.value!;
      return date.year == selected.year &&
          date.month == selected.month &&
          date.day == selected.day;
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
