// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:sample1/models/common_res_model.dart';
// import 'package:sample1/services/api_services.dart';
//
// class EditReadingController extends GetxController {
//   RxBool isLoading = false.obs;
//   final int readingId;
//   RxBool isSuccess = false.obs;
//   RxString message = "".obs;
//
//   EditReadingController(this.readingId);
//
//   final editReadingController = TextEditingController();
//   Future<void> editReading() async {
//     if (readingId == 0) {
//       isSuccess.value = false;
//       message.value = "Reading not yet";
//       Get.back();
//       return;
//     }
//     try {
//       final int? currentReading = int.tryParse(editReadingController.text);
//       isLoading.value = true;
//       CommonResModel commonResModel = await ApiServices.editReading(
//         currentReading ?? 0,
//         readingId,
//       );
//       isSuccess.value = commonResModel.success;
//       message.value = commonResModel.message;
//       Get.back();
//     } catch (e) {
//       isSuccess.value = false;
//       message.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
