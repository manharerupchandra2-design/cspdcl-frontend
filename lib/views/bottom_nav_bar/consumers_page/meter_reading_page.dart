// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sample1/models/consumer_detail_model/previous_bill.dart';
// import 'package:sample1/views/bottom_nav_bar/consumers_page/bill_page.dart';
//
// import '../../../controllers/consumer_controller/submit_reading_controller.dart';
// import '../../../models/consumer_model/consumer_model.dart';
//
// class MeterReadingPage extends StatelessWidget {
//   final Consumer consumer;
//
//   final PreviousBill previousBill;
//   MeterReadingPage({
//     super.key,
//     required this.consumer,
//     required this.previousBill,
//   });
//
//   late final SubmitReadingController submitReadingController = Get.put(
//     SubmitReadingController(consumerId: consumer.id, meterId: consumer.meterId),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Meter Reading")),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(16),
//
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Consumer Details",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//
//                   SizedBox(height: 10),
//
//                   Text("Consumer No : ${consumer.consumerNo}"),
//
//                   SizedBox(height: 5),
//
//                   Text("Name : ${consumer.name}"),
//
//                   SizedBox(height: 5),
//
//                   Text("Previous Reading : ${previousBill.currentReading}"),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 20),
//
//             Text(
//               "Meter Photo",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//
//             SizedBox(height: 10),
//
//             Obx(() {
//               if (submitReadingController.meterImage.value != null) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image.file(
//                     submitReadingController.meterImage.value!,
//                     width: double.infinity,
//                     height: 220,
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               }
//
//               return Container(
//                 height: 220,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: Colors.grey.shade400),
//                 ),
//                 child: const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.camera_alt_outlined, size: 60),
//                     SizedBox(height: 10),
//                     Text("No Photo Selected"),
//                   ],
//                 ),
//               );
//             }),
//
//             SizedBox(height: 15),
//
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//
//               child: OutlinedButton.icon(
//                   onPressed: () {
//                     submitReadingController.scanMeter();
//                   },
//                 icon: const Icon(Icons.camera_alt),
//                 label: const Text("Scan Meter"),
//               ),
//             ),
//
//             SizedBox(height: 20),
//
//             TextField(
//               keyboardType: TextInputType.number,
//               controller: submitReadingController.readController,
//               decoration: InputDecoration(
//                 labelText: "Current Reading",
//
//                 prefixIcon: Icon(Icons.speed),
//
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 15),
//
//             TextField(
//               maxLines: 3,
//
//               decoration: InputDecoration(
//                 labelText: "Remark (Optional)",
//
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 25),
//
//             SizedBox(
//               width: double.infinity,
//               height: 55,
//
//               child: Obx(() {
//                 return SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton.icon(
//                     onPressed: submitReadingController.isLoading.value
//                         ? null
//                         : () async {
//                             await submitReadingController.submitReading();
//
//                             Get.snackbar(
//                               submitReadingController.isSuccess.value
//                                   ? "Done"
//                                   : "Error",
//                               submitReadingController.message.value,
//                             );
//                           },
//
//                     icon: const Icon(Icons.check),
//
//                     label: submitReadingController.isLoading.value
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           )
//                         : const Text("Submit Reading"),
//                   ),
//                 );
//               }),
//             ),
//
//             SizedBox(height: 15),
//
//             const SizedBox(height: 15),
//
//             Obx(() {
//               return SizedBox(
//                 width: double.infinity,
//                 height: 55,
//
//                 child: ElevatedButton.icon(
//                   icon: const Icon(Icons.receipt_long),
//
//                   label: Text(
//                     submitReadingController.billGenerated.value
//                         ? "Bill Generated"
//                         : "Generate Bill",
//                   ),
//
//                   onPressed:
//                       submitReadingController.readingId.value == 0 ||
//                           submitReadingController.billGenerated.value
//                       ? null
//                       : () async {
//                           await submitReadingController.generateBill();
//
//                           final bill =
//                               submitReadingController.generatedBill.value;
//
//                           if (bill != null) {
//                             Get.offAll(() => GeneratedBillPage(bill: bill));
//                           }
//                         },
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample1/controllers/consumer_controller/edit_reading_controller.dart';
import '../../../controllers/consumer_controller/submit_reading_controller.dart';
import '../../../core/theme/theme.dart'; // ✅ ek import
import '../../../models/consumer_detail_model/previous_bill.dart';
import '../../../models/consumer_model/consumer_model.dart';
import 'bill_page.dart';

class MeterReadingPage extends StatelessWidget {
  final Consumer consumer;
  final PreviousBill? previousBill;

  MeterReadingPage({super.key, required this.consumer, this.previousBill});

  late final SubmitReadingController ctrl = Get.put(
    SubmitReadingController(consumerId: consumer.id, meterId: consumer.meterId),
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
            // ── Consumer Info ─────────────────────────
            InfoCard(
              title: "Consumer Details",
              titleIcon: Icons.person_outline,
              rows: [
                InfoRow("Consumer No", consumer.consumerNo),
                InfoRow("Name", consumer.name),
                InfoRow("Meter No", consumer.meterNo),
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

            Gap.h12,

            //Edit Reading
            // Obx(
            //   () => AppButton(
            //     label: "Edit Reading",
            //     icon: Icons.edit,
            //     isLoading: ctrl.isLoading.value,
            //     onPressed: () async {
            //       final editCtrl = Get.put(
            //         EditReadingController(ctrl.readingId.value),
            //       );
            //       Get.dialog(
            //         AlertDialog(
            //           title: Text("Edit Reading"),
            //           content: AppTextField(
            //             controller: editCtrl.editReadingController,
            //             label: "Current Reading (kWh)",
            //             hint: "e.g. 1450",
            //             prefixIcon: Icons.speed,
            //             keyboardType: TextInputType.number,
            //           ),
            //           actions: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 TextButton(
            //                   onPressed: () async {
            //                     await editCtrl.editReading();
            //                     Get.snackbar(
            //                       editCtrl.isSuccess.value ? "Done ✓" : "Error",
            //                       editCtrl.message.value,
            //                       backgroundColor: ctrl.isSuccess.value
            //                           ? AppColors.successLight
            //                           : AppColors.errorLight,
            //                       colorText: ctrl.isSuccess.value
            //                           ? AppColors.success
            //                           : AppColors.error,
            //                     );
            //
            //                   },
            //                   child: Text("save"),
            //                 ),
            //                 TextButton(
            //                   onPressed: () {
            //                     Get.back();
            //                   },
            //                   child: Text("cancel"),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Gap.h24,

            // ── Submit Button ─────────────────────────
            Obx(
              () => AppButton(
                label: "Submit Reading",
                icon: Icons.check_circle_outline,
                isLoading: ctrl.isLoading.value,
                onPressed: () async {
                  await ctrl.submitReading();
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

            // ── Generate Bill Button ──────────────────
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
