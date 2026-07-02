
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/consumer_controller/submit_reading_controller.dart';
import '../../../core/theme/theme.dart';
import '../../../models/consumer_detail_model/previous_bill.dart';
import '../../../models/consumer_model/consumer_model.dart';
import 'bill_page.dart';

class MeterReadingPage extends StatelessWidget {
  final Consumer consumer;
  final PreviousBill? previousBill;

  MeterReadingPage({super.key, required this.consumer, this.previousBill});

  late final SubmitReadingController ctrl = Get.put(
    SubmitReadingController(consumerId: consumer.id??0, meterId: consumer.meterId??0, meterType: consumer.meterType??''),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meter Reading")),

      body: SingleChildScrollView(
        padding: AppDimens.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Consumer Info
            InfoCard(
              title: "Consumer Details",
              titleIcon: Icons.person_outline,
              rows: [
                InfoRow("Consumer No", consumer.consumerNo??"No consumer number"),
                InfoRow("Name", consumer.name??"No name"),
                InfoRow("Meter No", consumer.meterNo??"No meter"),
                InfoRow(
                  "Prev Reading",
                  "${previousBill?.currentReading ?? 0} kWh",
                  valueColor: AppColors.info,
                ),
              ],
            ),

            Gap.h20,

            //Meter Photo
            const SectionHeader(title: "Meter Photo"),
            Gap.h10,

            Obx(() {
              final image = ctrl.meterImage.value;

              if (image != null) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: AppDimens.br16,
                      child: Image.file(
                        image,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Retake option
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: ctrl.scanMeter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.85),
                            borderRadius: AppDimens.brFull,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 14,
                              ),
                              Gap.w4,
                              Text(
                                "Retake",
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              //Photo Placeholder
              return GestureDetector(
                onTap: ctrl.scanMeter,
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: AppDimens.br16,
                    border: Border.all(
                      color: AppColors.border,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      Gap.h12,
                      Text(
                        "Tap to scan meter",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            Gap.h12,

            // Scan button
            AppButton(
              label: "Scan Meter",
              icon: Icons.camera_alt,
              isOutlined: true,
              onPressed: ctrl.scanMeter,
            ),

            Gap.h20,

            // Reading Input
            const SectionHeader(title: "Reading Details"),
            Gap.h12,

            AppTextField(
              controller: ctrl.readController,
              label: "Current Reading (kWh)",
              hint: "e.g. 1450",
              prefixIcon: Icons.speed,
              keyboardType: TextInputType.number,
            ),

            Gap.h24,

            //Submit Button
            Obx(
                  () => AppButton(
                label: "Submit Reading",
                icon: Icons.check_circle_outline,
                isLoading: ctrl.isLoading.value,
                onPressed: () async {
                  await ctrl.submitReading();

                  if (ctrl.needsForceConfirm.value) {
                    final confirm = await Get.dialog<bool>(
                      AlertDialog(
                        title: const Text("⚠️ Alert"),
                        content: Text(
                          "${ctrl.message.value}",style: AppTextStyles.h2,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(result: false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Get.back(result: true),
                            child: const Text(
                              "Submit again",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await ctrl.submitReading(force: true);
                    } else {
                      return;
                    }
                  }

                  Get.snackbar(
                    ctrl.isSuccess.value ? "Done ✓" : "Error",
                    ctrl.message.value,
                    backgroundColor: ctrl.isSuccess.value
                        ? AppColors.successLight
                        : AppColors.errorLight,
                    colorText: ctrl.isSuccess.value
                        ? AppColors.success
                        : AppColors.error,
                  );
                },
              ),
            ),

            Gap.h12,

            //Generate Bill Button
            Obx(() {
              final canGenerate =
                  ctrl.readingId.value != 0 && !ctrl.billGenerated.value;

              return AppButton(
                label: ctrl.billGenerated.value
                    ? "Bill Generated ✓"
                    : "Generate Bill",
                icon: ctrl.billGenerated.value
                    ? Icons.check_circle
                    : Icons.receipt_long,
                isOutlined: !canGenerate,
                color: ctrl.billGenerated.value ? AppColors.success : null,
                isLoading: ctrl.isBillLoading.value,
                onPressed: canGenerate
                    ? () async {
                        await ctrl.generateBill();
                        final bill = ctrl.generatedBill.value;
                        if (bill != null) {
                          Get.offAll(() => GeneratedBillPage(bill: bill));
                        }
                      }
                    : null,
              );
            }),

            Gap.h20,
          ],
        ),
      ),
    );
  }
}
