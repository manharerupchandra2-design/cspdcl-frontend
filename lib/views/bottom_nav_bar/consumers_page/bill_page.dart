// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:sample1/controllers/bottom_nav_controller/bottom_nav_controller.dart';
// import 'package:sample1/views/bottom_nav_bar/home_page.dart';
//
// import '../../../controllers/dashboard_controller/dashboard_controller.dart';
// import '../../../models/consumer_detail_model/bill_model.dart';
// import '../dashboard_page.dart';
//
// class GeneratedBillPage extends StatelessWidget {
//   final BillData bill;
//
//   const GeneratedBillPage({super.key, required this.bill});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Bill Receipt")),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//
//         child: Card(
//           elevation: 5,
//
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//               children: [
//                 const Center(
//                   child: Text(
//                     "CSPDCL ELECTRICITY BILL",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//
//                 const Divider(height: 30),
//
//                 Text("Consumer : ${bill.consumerName}"),
//
//                 Text("Consumer No : ${bill.consumerNo}"),
//
//                 Text("Meter No : ${bill.meterNo}"),
//
//                 const SizedBox(height: 20),
//
//                 Text("Previous Reading : ${bill.previousReading}"),
//
//                 Text("Current Reading : ${bill.currentReading}"),
//
//                 Text("Units Consumed : ${bill.units}"),
//
//                 const Divider(height: 30),
//
//                 Center(
//                   child: Text(
//                     "₹ ${bill.amount}",
//                     style: const TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 const Center(child: Text("Bill Generated Successfully")),
//                 const SizedBox(height: 30),
//
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       // Dashboard counts refresh
//                       final dashboardController =
//                           Get.find<DashboardController>();
//
//                       await dashboardController.getDashboard();
//                       final btmnavController = Get.find<BottomNavController>();
//                       btmnavController.selectedIndex(0);
//                       // Saare previous pages remove karke dashboard kholo
//                       Get.offAll(() => HomePage());
//                     },
//                     child: const Text("Go To Dashboard"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/bottom_nav_controller/bottom_nav_controller.dart';
import '../../../controllers/dashboard_controller/dashboard_controller.dart';
import '../../../core/theme/theme.dart'; // ✅ ek import
import '../../../models/consumer_detail_model/bill_model.dart';
import '../home_page.dart';

class GeneratedBillPage extends StatelessWidget {
  final BillData bill;
  const GeneratedBillPage({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bill Receipt")),

      body: SingleChildScrollView(
        padding: AppDimens.pagePadding,
        child: Column(
          children: [

            // ── Success Banner ────────────────────────
            GradientCard(
              colors: [AppColors.success, Color(0xFF2ECC71)],
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle,
                        color: Colors.white, size: 32),
                  ),
                  Gap.w14,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bill Generated!",
                          style: AppTextStyles.onPrimaryH2),
                      Gap.h4,
                      Text("Successfully submitted",
                          style: AppTextStyles.onPrimaryBody),
                    ],
                  ),
                ],
              ),
            ),

            Gap.h16,

            // ── Bill Header ───────────────────────────
            AppCard(
              child: Column(
                children: [
                  // CSPDCL Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.electric_bolt,
                          color: AppColors.accent, size: 20),
                      Gap.w8,
                      Text(
                        "CSPDCL ELECTRICITY BILL",
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),

                  Gap.h16,

                  // Amount Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.06),
                      borderRadius: AppDimens.br12,
                    ),
                    child: Column(
                      children: [
                        Text("Total Amount",
                            style: AppTextStyles.labelLarge),
                        Gap.h6,
                        Text(
                          "₹ ${bill.amount}",
                          style: AppTextStyles.amountLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Gap.h12,

            // ── Consumer Info ─────────────────────────
            InfoCard(
              title: "Consumer Information",
              titleIcon: Icons.person_outline,
              rows: [
                InfoRow("Consumer",    bill.consumerName),
                InfoRow("Consumer No", bill.consumerNo),
                InfoRow("Meter No",    bill.meterNo),
              ],
            ),

            Gap.h12,

            // ── Reading Info ──────────────────────────
            InfoCard(
              title: "Reading Details",
              titleIcon: Icons.speed_outlined,
              rows: [
                InfoRow("Previous Reading",
                    "${bill.previousReading} kWh"),
                InfoRow("Current Reading",
                    "${bill.currentReading} kWh"),
                InfoRow("Units Consumed",
                    "${bill.units} units",
                    valueColor: AppColors.info),
                InfoRow("Bill Amount",
                    "₹ ${bill.amount}",
                    valueColor: AppColors.success),
              ],
            ),

            Gap.h24,

            // ── Buttons ───────────────────────────────
            AppButton(
              label: "Go to Dashboard",
              icon: Icons.dashboard_outlined,
              onPressed: () async {
                await Get.find<DashboardController>().getDashboard();
                Get.find<BottomNavController>().selectedIndex(0);
                Get.offAll(() => HomePage());
              },
            ),

            Gap.h12,

            AppButton(
              label: "Print / Share Bill",
              icon: Icons.share_outlined,
              isOutlined: true,
              onPressed: () {
                // Print/share logic yahan aayega
              },
            ),

            Gap.h20,
          ],
        ),
      ),
    );
  }
}