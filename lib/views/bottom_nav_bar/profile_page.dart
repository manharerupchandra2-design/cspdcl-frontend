import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller/dashboard_controller.dart';
import '../../core/theme/theme.dart';
import '../login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final name = box.read("name") ?? "Meter Reader";
    final email = box.read("email") ?? "-";
    final mobile = box.read("mobile") ?? "-";
    final id = box.read("id")?.toString() ?? "-";
    final zone = box.read("zone") ?? "-";

    return Scaffold(
      body: SingleChildScrollView(
        padding: AppDimens.pagePadding,
        child: Column(
          children: [
            Gap.h20,

            //Avatar + Name
            GradientCard(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.accent,
                    child: Text(
                      name[0].toUpperCase(),
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.textOnAccent,
                      ),
                    ),
                  ),
                  Gap.w16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: AppTextStyles.onPrimaryH2),
                        Gap.h4,
                        Text(
                          "Meter Reader",
                          style: AppTextStyles.onPrimaryBody,
                        ),
                        Gap.h8,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.2),
                            borderRadius: AppDimens.brFull,
                            border: Border.all(
                              color: AppColors.accent.withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            "Active",
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Gap.h20,

            //Profile Info
            InfoCard(
              title: "Personal Information",
              titleIcon: Icons.person_outline,
              rows: [
                InfoRow("Employee ID", id),
                InfoRow("Mobile", mobile),
                InfoRow("Email", email),
                InfoRow("Zone", zone),
              ],
            ),

            Gap.h12,

            //App Info
            InfoCard(
              title: "App Information",
              titleIcon: Icons.info_outline,
              rows: [
                InfoRow("App Version", "1.0.0"),
                InfoRow("Department", "CSPDCL"),
                InfoRow("Division", "Raipur"),
              ],
            ),
            Gap.h24,
            Obx(() {
              if(!Get.isRegistered<DashboardController>()){
                return const SizedBox();
              }
              final ctrl = Get.find<DashboardController>();
              return InfoCard(
                title: "My Stats",
                titleIcon: Icons.bar_chart_outlined,
                rows: [
                  InfoRow(
                    "Total Readings",
                    ctrl.totalReadings.value.toString(),
                  ),
                  InfoRow("Total Bills", ctrl.totalBills.value.toString()),
                  InfoRow(
                    "Today Readings",
                    ctrl.todayReadings.value.toString(),
                  ),
                  InfoRow("Pending Today", ctrl.totalPending.value.toString()),
                ],
              );
            }),

            Gap.h24,

            //Logout Button
            AppButton(
              label: "Logout",
              icon: Icons.logout,
              color: AppColors.error,
              onPressed: () {
                box.erase();
                Get.deleteAll(force: true);
                Get.put(AuthController(), permanent: true);
                Get.offAll(() => LoginPage());
              },
            ),

            Gap.h20,
          ],
        ),
      ),
    );
  }
}
