import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../models/consumer_model/consumer_model.dart';
import '../../services/api_services.dart';

class ConsumerListController extends GetxController {
  RxBool isLoading = false.obs;

  RxInt totalConsumers = 0.obs;

  RxList<Consumer> consumers = <Consumer>[].obs;

  RxList<Consumer> filteredConsumers = <Consumer>[].obs;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getConsumers();
    });
  }

  Future<void> getConsumers() async {
    try {
      isLoading.value = true;

      final response = await ApiServices.getConsumers();

      totalConsumers.value = response?.data.totalConsumers ?? 0;

      consumers.assignAll(response?.data.consumers ?? []);

      filteredConsumers.assignAll(response?.data.consumers ?? []);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void searchConsumer(String value) {
    filteredConsumers.assignAll(
      consumers.where(
        (consumer) =>
            consumer.name!.toLowerCase().contains(value.toLowerCase()) ||
            consumer.meterNo!.toLowerCase().contains(value.toLowerCase()),
      ),
    );
  }
}
