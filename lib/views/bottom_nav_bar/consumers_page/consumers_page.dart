
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/consumer_controller/consumer_list_controller.dart';
import '../../../core/theme/theme.dart';
import 'consumer_detail_page.dart';

class ConsumersPage extends StatelessWidget {
  const ConsumersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ConsumerListController>();
    final searchController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          //Search + Count
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              children: [
                AppTextField(
                  controller: searchController, // ✅ controller ka use
                  label: "Search Consumer",
                  prefixIcon: Icons.search,
                  onChanged: ctrl.searchConsumer,
                ),
                Gap.h12,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Consumers", style: AppTextStyles.labelLarge),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: AppDimens.brFull,
                        ),
                        child: Text(
                          ctrl.totalConsumers.value.toString(),
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //List
          Expanded(
            child: Obx(() {
              if (ctrl.isLoading.value) {
                return const LoadingState(message: "Loading...");
              }

              if (ctrl.filteredConsumers.isEmpty) {
                return EmptyState(
                  message: searchController.text.isNotEmpty
                      ? "\"${searchController.text}\""
                      : "No result",
                  icon: Icons.people_outline,
                  actionLabel: "Refresh",
                  onAction: ctrl.getConsumers,
                );
              }

              return RefreshIndicator(onRefresh: ()async{
                await ctrl.getConsumers();
              },
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  itemCount: ctrl.filteredConsumers.length,
                  itemBuilder: (context, index) {
                    final consumer = ctrl.filteredConsumers[index];
                    return _ConsumerCard(consumer: consumer, index: index);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

//Consumer Card
class _ConsumerCard extends StatelessWidget {
  final dynamic consumer;
  final int index;

  const _ConsumerCard({required this.consumer, required this.index});

  Color get _avatarColor {
    final colors = [
      AppColors.primary,
      AppColors.info,
      AppColors.success,
      AppColors.warning,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        padding: const EdgeInsets.all(12),
        onTap: () => Get.to(() => ConsumerDetailPage(consumer: consumer)),
        child: Row(
          children: [
            //Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: _avatarColor.withOpacity(0.15),
              child: Text(
                consumer.name[0].toUpperCase(),
                style: AppTextStyles.h3.copyWith(color: _avatarColor),
              ),
            ),

            Gap.w12,

            //Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(consumer.name, style: AppTextStyles.h4),
                  Gap.h4,
                  _infoText(
                    Icons.badge_outlined,
                    "Consumer: ${consumer.consumerNo}",
                  ),
                  Gap.h2,
                  _infoText(
                    Icons.electric_meter_outlined,
                    "Meter: ${consumer.meterNo}",
                  ),
                  Gap.h2,
                  _infoText(Icons.location_on_outlined, consumer.address),
                ],
              ),
            ),

            // ── Status + Arrow ───────────────────────
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     StatusBadge(status: consumer.status ?? "pending"),
            //     Gap.h8,
            //     const Icon(
            //       Icons.arrow_forward_ios,
            //       size: 14,
            //       color: AppColors.textHint,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _infoText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.textHint),
        Gap.w4,
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
