// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:sample1/controllers/dashboard_controller/dashboard_controller.dart';
// import 'package:sample1/utils/app_spacing.dart';
//
// import '../../core/theme/app_dimensions.dart';
// import '../../core/theme/app_text_styles.dart';
// import '../../core/theme/app_widgets.dart';
//
// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final dashboardController = Get.find<DashboardController>();
//     final box = GetStorage();
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GradientCard(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Welcome", style: AppTextStyles.onPrimaryBody),
//                   Gap.h4,
//                   Text(box.read("name"), style: AppTextStyles.onPrimaryH2),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//
//             const Text(
//               "Overview",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//
//             AppSpacing.h12,
//
//             Obx(() {
//               return Row(
//                 children: [
//                   Expanded(
//                     child: _dashboardCard(
//                       title: "Consumers",
//                       value: dashboardController.totalConsumers.value
//                           .toString(),
//                       icon: Icons.people,
//                     ),
//                   ),
//
//                   const SizedBox(width: 12),
//
//                   Expanded(
//                     child: _dashboardCard(
//                       title: "Readings",
//                       icon: Icons.speed,
//                       value: dashboardController.totalReadings.value.toString(),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//
//             const SizedBox(height: 12),
//
//             Row(
//               children: [
//                 Expanded(
//                   child: _dashboardCard(
//                     title: "Pending",
//                     value: "130",
//                     icon: Icons.pending_actions,
//                   ),
//                 ),
//
//                 const SizedBox(width: 12),
//
//                 Expanded(
//                   child: _dashboardCard(
//                     title: "Bills",
//                     value: dashboardController.totalBills.value.toString(),
//                     icon: Icons.receipt_long,
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 24),
//
//             const Text(
//               "Quick Actions",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 12),
//
//             GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               childAspectRatio: 1.3,
//
//               children: [
//                 _actionCard(icon: Icons.people, title: "Consumers"),
//
//                 _actionCard(icon: Icons.camera_alt, title: "Take Reading"),
//
//                 _actionCard(icon: Icons.history, title: "History"),
//
//                 _actionCard(icon: Icons.receipt, title: "Bills"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _dashboardCard({
//     required String title,
//     required String value,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//
//       child: Column(
//         children: [
//           Icon(icon, size: 35),
//           const SizedBox(height: 10),
//
//           Text(
//             value,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//
//           const SizedBox(height: 4),
//
//           Text(title),
//         ],
//       ),
//     );
//   }
//
//   Widget _actionCard({
//     required IconData icon,
//     required String title,
//     final VoidCallback? onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 35),
//             const SizedBox(height: 10),
//             Text(title),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sample1/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:sample1/core/theme/theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<DashboardController>();
    final box = GetStorage();

    return Scaffold(
      body: SingleChildScrollView(
        padding: AppDimens.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Welcome Card
            GradientCard(
              colors: [AppColors.success, Color(0xFF2ECC71)],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back", style: AppTextStyles.onPrimaryBody),
                  Gap.h4,
                  Text(
                    box.read("name") ?? "Meter Reader",
                    style: AppTextStyles.onPrimaryH2,
                  ),
                ],
              ),
            ),

            Gap.h20,

            //Overview
            const SectionHeader(title: "Overview"),
            Gap.h12,

            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: "Consumers",
                      value: ctrl.totalConsumers.value.toString(),
                      icon: Icons.people,
                      color: AppColors.primary,
                    ),
                  ),
                  Gap.w12,
                  Expanded(
                    child: StatCard(
                      title: "Readings",
                      value: ctrl.totalReadings.value.toString(),
                      icon: Icons.speed,
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
            ),

            Gap.h12,

            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: "Pending",
                      value: ctrl.totalPending.value.toString(),
                      icon: Icons.pending_actions,
                      color: AppColors.warning,
                    ),
                  ),
                  Gap.w12,
                  Expanded(
                    child: StatCard(
                      title: "Bills",
                      value: ctrl.totalBills.value.toString(),
                      icon: Icons.receipt_long,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),

            Gap.h24,

            //Quick Actions
            const SectionHeader(title: "Quick Actions"),
            Gap.h12,

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                ActionCard(
                  icon: Icons.people,
                  title: "Consumers",
                  color: AppColors.primary,
                  onTap: () {},
                ),
                ActionCard(
                  icon: Icons.camera_alt,
                  title: "Take Reading",
                  color: AppColors.accent,
                  onTap: () {},
                ),
                ActionCard(
                  icon: Icons.history,
                  title: "History",
                  color: AppColors.info,
                  onTap: () {},
                ),
                ActionCard(
                  icon: Icons.receipt,
                  title: "Bills",
                  color: AppColors.success,
                  onTap: () {},
                ),
              ],
            ),

            Gap.h20,
          ],
        ),
      ),
    );
  }
}
