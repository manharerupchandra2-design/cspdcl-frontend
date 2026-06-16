import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sample1/controllers/bottom_nav_controller/bottom_nav_controller.dart';
import 'package:sample1/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:sample1/core/theme/theme.dart';
import 'package:sample1/views/bottom_nav_bar/consumers_page/pending_consumers_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<DashboardController>();
    final navCtrl = Get.find<BottomNavController>();
    final box = GetStorage();

    // Greeting
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? "Good Morning"
        : hour < 17
        ? "Good Afternoon"
        : "Good Evening";

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ctrl.getDashboard();
        },
        child: SingleChildScrollView(
          padding: AppDimens.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              GradientCard(
                colors: [AppColors.primary, AppColors.info],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$greeting 👋",
                          style: AppTextStyles.onPrimaryBody,
                        ),
                        Gap.h4,
                        Text(
                          box.read("name") ?? "Meter Reader",
                          style: AppTextStyles.onPrimaryH2,
                        ),
                        Gap.h4,
                        // Text(
                        //   box.read("zone") ?? "",
                        //   style: AppTextStyles.onPrimaryBody,
                        // ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 12,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 4),
                              Text(
                                box.read("zone") ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Text(
                        (box.read("name") ?? "M")[0].toUpperCase(),
                        style: AppTextStyles.h1.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              Gap.h20,

              // Aaj Ka Summary
              const SectionHeader(title: "Today's Summary"),
              Gap.h12,

              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: "Today Readings",
                        value: ctrl.todayReadings.value.toString(),
                        icon: Icons.speed,
                        color: AppColors.info,
                      ),
                    ),
                    Gap.w12,
                    Expanded(
                      child: StatCard(
                        title: "Today Bills",
                        value: ctrl.todayBills.value.toString(),
                        icon: Icons.receipt_long,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),

              Gap.h12,

              // Progress Bar
              Obx(() {
                final total = ctrl.totalConsumers.value;
                final done = ctrl.todayReadings.value;
                final progress = total == 0 ? 0.0 : done / total;

                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Progress",
                            style: AppTextStyles.labelLarge,
                          ),
                          Text(
                            "$done / $total",
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      Gap.h8,
                      ClipRRect(
                        borderRadius: AppDimens.brFull,
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 10, // 8 se 10
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progress == 1.0 ? Colors.green : Colors.blue,
                          ),
                        ),

                      ),
                      Gap.h6,
                      Text(
                        ctrl.totalPending.value == 0
                            ? "All done! 🎉"
                            : "${ctrl.totalPending.value} consumers pending",
                        style: AppTextStyles.caption.copyWith(
                          color: ctrl.totalPending.value == 0
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              Gap.h20,

              // Overview
              const SectionHeader(title: "Overall Stats"),
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
                      child: GestureDetector(
                        onTap: () => Get.to(() => PendingConsumersPage()),
                        child: StatCard(
                          title: "Pending",
                          value: ctrl.totalPending.value.toString(),
                          icon: Icons.pending_actions,
                          color: AppColors.warning,
                        ),
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

              Gap.h20,

              // Recent Activity
              const SectionHeader(title: "Recent Activity"),
              Gap.h12,

              Obx(() {
                if (ctrl.recentReadings.isEmpty) {
                  return const EmptyState(
                    message: "No recent readings",
                    icon: Icons.history_outlined,
                  );
                }
                return Column(
                  children: ctrl.recentReadings.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppCard(
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: AppDimens.br10,
                              ),
                              child: const Icon(
                                Icons.electric_meter_outlined,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                            Gap.w12,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.consumerName,
                                    style: AppTextStyles.labelLarge,
                                  ),
                                  Gap.h2,
                                  Text(
                                    item.consumerNo,
                                    style: AppTextStyles.caption,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${item.currentReading} kWh",
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                Gap.h2,
                                Text(
                                  item.readingDate.isNotEmpty
                                      ? DateFormat("dd MMM").format(
                                          DateTime.parse(item.readingDate),
                                        )
                                      : "",
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),

              Gap.h20,

              // Quick Actions
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
                    onTap: () => navCtrl.changeIndex(1),
                  ),
                  ActionCard(
                    icon: Icons.camera_alt,
                    title: "Take Reading",
                    color: AppColors.accent,
                    onTap: () => navCtrl.changeIndex(1),
                  ),
                  ActionCard(
                    icon: Icons.history,
                    title: "History",
                    color: AppColors.info,
                    onTap: () => navCtrl.changeIndex(2),
                  ),
                  ActionCard(
                    icon: Icons.receipt,
                    title: "Bills",
                    color: AppColors.success,
                    onTap: () => navCtrl.changeIndex(2),
                  ),
                ],
              ),

              Gap.h20,
            ],
          ),
        ),
      ),
    );
  }
}
