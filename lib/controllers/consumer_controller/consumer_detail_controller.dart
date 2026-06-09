import 'package:get/get.dart';

import '../../models/consumer_detail_model/consumer_detail.dart';
import '../../models/consumer_detail_model/previous_bill.dart';
import '../../services/api_services.dart';

class ConsumerDetailController extends GetxController {
  final int consumerId;

  ConsumerDetailController(this.consumerId);

  RxBool isLoading = false.obs;

  Rxn<ConsumerDetail> consumer = Rxn<ConsumerDetail>();

  Rxn<PreviousBill> previousBill = Rxn<PreviousBill>();

  @override
  void onInit() {
    super.onInit();
    getConsumerDetail();
  }

  Future<void> getConsumerDetail() async {
    try {
      isLoading.value = true;

      final response = await ApiServices.getConsumerDetail(consumerId);

      consumer.value = response?.data.consumer;

      previousBill.value = response?.data.previousBill;
    } finally {
      isLoading.value = false;
    }
  }
}
