import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/consumer_detail_model/bill_model.dart';
import '../../models/consumer_detail_model/set_reading_model.dart';
import '../../services/api_services.dart';

import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../views/camera_overlay_page.dart';

class SubmitReadingController extends GetxController {
  RxInt readingId = 0.obs;
  RxString message = ''.obs;
  Rx<File?> meterImage = Rx<File?>(null);
  RxBool isSuccess = false.obs;
  RxBool isLoading = false.obs;

  RxBool isBillLoading = false.obs;
  RxBool billGenerated = false.obs;

  Rxn<BillData> generatedBill = Rxn<BillData>();

  final readController = TextEditingController();

  final int consumerId;
  final int meterId;

  SubmitReadingController({required this.meterId, required this.consumerId});

  Future<void> submitReading() async {
    try {
      print(consumerId);
      print("MeterId : $meterId");

      isLoading.value = true;

      final reading = int.tryParse(readController.text);

      if (reading == null) {
        Get.snackbar("Error", "Invalid reading");
        return;
      }

      final box = GetStorage();

      final request = SetReadingRequest(
        meterId: meterId,
        readerId: box.read('id') ?? 0,
        currentReading: reading,
        meterPhoto: meterImage.value,
      );

      final response = await ApiServices.setReading(consumerId, request);

      readingId.value = response?.readingId ?? 0;

      message.value = response?.message ?? '';

      isSuccess.value = response?.success ?? false;
      readController.clear();
    } catch (e) {
      isSuccess.value = false;

      message.value = e.toString();

      print(message.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> scanMeter() async {
    try {

      final imagePath = await Get.to(() => const CameraOverlayPage());

      if (imagePath == null) return;

      meterImage.value = File(imagePath);

      final inputImage = InputImage.fromFilePath(imagePath);
      final textRecognizer = TextRecognizer();
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      String extractedText = recognizedText.text;
      print("OCR Result : $extractedText");

      final matches = RegExp(r'\d+').allMatches(extractedText);

      if (matches.isNotEmpty) {
        String reading = matches
            .map((e) => e.group(0)!)
            .reduce((a, b) => a.length > b.length ? a : b);

        readController.text = reading;
      } else {
        Get.snackbar("Error", "No reading detected");
      }

      await textRecognizer.close();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> generateBill() async {
    try {
      if (readingId.value == 0) {
        Get.snackbar("Error", "Submit reading first");
        return;
      }

      isBillLoading.value = true;

      final response = await ApiServices.generateBill(readingId.value);

      if (response != null) {
        generatedBill.value = response.data;

        billGenerated.value = true;

        Get.snackbar("Success", response.message);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", e.toString());
    } finally {
      isBillLoading.value = false;
    }
  }
}
