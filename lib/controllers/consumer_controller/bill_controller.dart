import 'package:get/get.dart';

import '../../services/api_services.dart';

class GeneratedBillController extends GetxController {

  final int billId;

  GeneratedBillController(this.billId);

  RxBool isLoading = false.obs;

  RxString consumerName = ''.obs;
  RxString consumerNo = ''.obs;
  RxString meterNo = ''.obs;

  RxInt previousReading = 0.obs;
  RxInt currentReading = 0.obs;
  RxInt units = 0.obs;

  RxDouble amount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getBill();
  }

  Future<void> getBill() async {
    try {
      isLoading.value = true;

      final response =
      await ApiServices.generateBill(billId);

      consumerName.value =
          response?.data.consumerName ?? '';

      consumerNo.value =
          response?.data.consumerNo ?? '';

      meterNo.value =
          response?.data.meterNo ?? '';

      previousReading.value =
          response?.data.previousReading ?? 0;

      currentReading.value =
          response?.data.currentReading ?? 0;

      units.value =
          response?.data.units ?? 0;

      amount.value =
          response?.data.amount ?? 0;

    } finally {
      isLoading.value = false;
    }
  }
}