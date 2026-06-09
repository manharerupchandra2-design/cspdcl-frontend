import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../models/dashboard_controller/dashboard_controller.dart';
import '../../services/api_services.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;

  RxInt totalConsumers = 0.obs;
  RxInt totalReadings = 0.obs;
  RxInt totalBills = 0.obs;
  RxInt totalPending = 0.obs;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getDashboard();
    });
  }

  Future<void> getDashboard() async {
    try {
      isLoading.value = true;

      DashboardResponse? response = await ApiServices.getDashboard();

      totalConsumers.value = response?.data.totalConsumers ?? 0;

      totalReadings.value = response?.data.totalReadings ?? 0;

      totalBills.value = response?.data.totalBills ?? 0;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
