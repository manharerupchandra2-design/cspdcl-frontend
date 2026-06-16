// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sample1/controllers/consumer_controller/consumer_detail_controller.dart';
// import 'package:sample1/models/consumer_detail_model/consumer_detail.dart';
// import 'package:sample1/views/bottom_nav_bar/consumers_page/meter_reading_page.dart';
//
// import '../../../models/consumer_model/consumer_model.dart';
//
// class ConsumerDetailPage extends StatelessWidget {
//   final Consumer consumer;
//   const ConsumerDetailPage({super.key, required this.consumer});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final consumerDetailController = Get.put(
//       ConsumerDetailController(consumer.id),
//     );
//     return Scaffold(
//       appBar: AppBar(title: Text("Consumer Detail")),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Consumer Information",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//
//                   SizedBox(height: 15),
//
//                   Text("Name : ${consumer.name}"),
//
//                   SizedBox(height: 8),
//
//                   Text("Consumer No : ${consumer.consumerNo}"),
//
//                   SizedBox(height: 8),
//
//                   Text("Mobile : ${consumer.mobile}"),
//
//                   SizedBox(height: 8),
//
//                   Text("Address : ${consumer.address}"),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
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
//                     "Meter Information",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//
//                   SizedBox(height: 15),
//
//                   Text("Meter No : ${consumer.meterNo}"),
//
//                   SizedBox(height: 8),
//
//                   Text("Connection Type : ${consumer.meterType}"),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//
//               child: Obx(() {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Previous Bill",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                     SizedBox(height: 15),
//
//                     Text(
//                       "Previous Reading : ${consumerDetailController.previousBill.value?.currentReading}",
//                     ),
//
//                     SizedBox(height: 8),
//
//                     Text(
//                       "Previous Units : ${consumerDetailController.previousBill.value?.units}",
//                     ),
//
//                     SizedBox(height: 8),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Bill Amount : ${(consumerDetailController.previousBill.value?.amount)}",
//                         ),
//                         // Obx(() {
//                         //   if (consumerDetailController.previousBill.value?.amount !=
//                         //       "0") {
//                         //     return SizedBox.shrink();
//                         //   }
//                         //   return InkWell(
//                         //     onTap: billController.isLoading.value
//                         //         ? null
//                         //         : () async {
//                         //       print(readingController.readingId.value);
//                         //             await billController.setBilling(
//                         //               consumer.meterType,
//                         //               readingController.readingId.value,
//                         //             );
//                         //           },
//                         //     child: Container(
//                         //       width: 100,
//                         //       height: 30,
//                         //       alignment: Alignment.center,
//                         //       decoration: BoxDecoration(
//                         //         color: Colors.amber,
//                         //         borderRadius: BorderRadius.circular(12),
//                         //       ),
//                         //       child: Text("billing here"),
//                         //     ),
//                         //   );
//                         // }),
//                       ],
//                     ),
//                   ],
//                 );
//               }),
//             ),
//
//             const SizedBox(height: 25),
//
//             SizedBox(
//               width: double.infinity,
//               height: 55,
//
//               child: Obx(() {
//                 if (consumerDetailController.previousBill.value == null) {
//                   return CircularProgressIndicator();
//                 }
//                 return ElevatedButton.icon(
//                   onPressed: () {
//                     Get.to(
//                       () => MeterReadingPage(
//                         consumer: consumer,
//                         previousBill:
//                             consumerDetailController.previousBill.value!,
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.camera_alt),
//                   label: const Text("Take Meter Reading"),
//                 );
//               }),
//             ),
//
//             const SizedBox(height: 12),
//
//             // SizedBox(
//             //   width: double.infinity,
//             //   height: 55,
//             //
//             //   child: OutlinedButton.icon(
//             //     onPressed: () {},
//             //     icon: const Icon(Icons.receipt_long),
//             //     label: const Text("Generate Bill"),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample1/controllers/consumer_controller/submit_reading_controller.dart';
import '../../../controllers/consumer_controller/consumer_detail_controller.dart';
import '../../../core/theme/theme.dart'; // ✅ ek import
import '../../../models/consumer_model/consumer_model.dart';
import 'meter_reading_page.dart';

class ConsumerDetailPage extends StatelessWidget {
  final Consumer consumer;
  const ConsumerDetailPage({super.key, required this.consumer});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ConsumerDetailController(consumer.id??0));

    return Scaffold(
      appBar: AppBar(title: const Text("Consumer Detail")),

      body: SingleChildScrollView(
        padding: AppDimens.pagePadding,
        child: Column(
          children: [
            // ── Consumer Info ─────────────────────────
            InfoCard(
              title: "Consumer Information",
              titleIcon: Icons.person_outline,
              rows: [
                InfoRow("Name", consumer.name??"No name"),
                InfoRow("Consumer No", consumer.consumerNo??"No consumer number"),
                InfoRow("Mobile", consumer.mobile??"No mobile"),
                InfoRow("Address", consumer.address??"No address"),
              ],
            ),

            Gap.h12,

            // ── Meter Info ────────────────────────────
            InfoCard(
              title: "Meter Information",
              titleIcon: Icons.electric_meter_outlined,
              rows: [
                InfoRow("Meter No", consumer.meterNo??"No"),
                InfoRow("Connection", consumer.meterType??"No"),
              ],
            ),

            Gap.h12,

            //Previous Bill
            Obx(() {
              final bill = ctrl.previousBill.value;

              return bill != null
                  ? InfoCard(
                      title: "Previous Bill",
                      titleIcon: Icons.receipt_outlined,
                      isLoading: bill == null,
                      rows: bill == null
                          ? []
                          : [
                              InfoRow(
                                "Previous Reading",
                                "${bill.currentReading} kWh",
                              ),
                              InfoRow("Units Consumed", "${bill.units} units"),
                              InfoRow(
                                "Bill Amount",
                                "₹ ${bill.totalAmount}",
                                valueColor: AppColors.success,
                              ),
                            ],
                    )
                  : Text("newly added");
            }),
            Gap.h24,
            //Scan Button
            Obx(() {
              final bill = ctrl.previousBill.value;
              return AppButton(
                label: "Take Meter Reading",
                icon: Icons.camera_alt,
                isLoading: ctrl.isLoading.value,
                onPressed: ctrl.isLoading.value
                    ? null
                    : () => Get.to(
                        () => MeterReadingPage(
                          consumer: consumer,
                          previousBill: bill,
                        ),
                      ),
              );
            }),

            Gap.h12,
            // Obx(() {
            //   final subReadingController = Get.find<SubmitReadingController>();
            //   final bill = ctrl.previousBill.value;
            //   return subReadingController.billGenerated.value
            //       ? TextButton(
            //           onPressed: () {
            //
            //             Get.off(
            //               () => MeterReadingPage(
            //                 consumer: consumer,
            //                 previousBill: bill,
            //               ),
            //             );
            //           },
            //           child: Text("Bill Not Yet?"),
            //         )
            //       : const SizedBox();
            // }),

            //Generate Bill
            // AppButton(
            //   label: "Generate Bill",
            //   icon: Icons.receipt_long,
            //   isOutlined: true,
            //   onPressed: (){
            //     final submitReadingController = Get.find<SubmitReadingController>();
            //     if(submitReadingController.isSuccess.value=true){
            //
            //     }
            //   }, // enable karo jab reading ho jaaye
            // ),
          ],
        ),
      ),
    );
  }
}
