import 'package:get/get.dart';
import 'bottom_nav_controller/bottom_nav_controller.dart';
import 'consumer_controller/bill_history_controller.dart';
import 'consumer_controller/consumer_list_controller.dart';
import 'consumer_controller/reading_history_controller.dart';
import 'dashboard_controller/dashboard_controller.dart';

void ensureControllersInitialized() {
  if (!Get.isRegistered<BottomNavController>()) {
    Get.put(BottomNavController());
  }
  if (!Get.isRegistered<DashboardController>()) {
    Get.put(DashboardController());
  }
  if (!Get.isRegistered<ConsumerListController>()) {
    Get.put(ConsumerListController());
  }
  if (!Get.isRegistered<ReadingHistoryController>()) {
    Get.put(ReadingHistoryController());
  }
  if (!Get.isRegistered<BillHistoryController>()) {
    Get.put(BillHistoryController());
  }
}