import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/consumer_model/consumer_model.dart';
import '../../../services/api_services.dart';

class PendingConsumerController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Consumer> pendingConsumers = <Consumer>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPendingConsumers();
  }

  Future<void> getPendingConsumers() async {
    try {
      isLoading.value = true;
      final response = await ApiServices.getPendingConsumers();
      print('PENDING RESPONSE: ${response?.data.consumers.length}');
      pendingConsumers.value = response?.data.consumers ?? [];
    } catch (e) {
      print("Pending Error : $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
