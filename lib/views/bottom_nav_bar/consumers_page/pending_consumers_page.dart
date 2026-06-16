// views/bottom_nav_bar/consumers_page/pending_consumers_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/consumer_controller/pending_consumer_controller.dart';
import '../../../core/theme/theme.dart';
import 'consumer_detail_page.dart';

class PendingConsumersPage extends StatelessWidget {
  const PendingConsumersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(PendingConsumerController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          "Pending (${ctrl.pendingConsumers.length})",
        )),
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const LoadingState(message: "Loading pending...");
        }

        if (ctrl.pendingConsumers.isEmpty) {
          return const EmptyState(
            message: "All readings done for today! 🎉",
            icon: Icons.check_circle_outline,
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ctrl.getPendingConsumers();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ctrl.pendingConsumers.length,
            itemBuilder: (context, index) {
              final consumer = ctrl.pendingConsumers[index];
              return _PendingCard(consumer: consumer, index: index);
            },
          ),
        );
      }),
    );
  }
}

class _PendingCard extends StatelessWidget {
  final dynamic consumer;
  final int index;
  const _PendingCard({required this.consumer, required this.index});

  Color get _avatarColor {
    final colors = [
      AppColors.warning,
      AppColors.error,
      AppColors.info,
      AppColors.primary,
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
            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: _avatarColor.withOpacity(0.15),
              child: Text(
                consumer.name[0].toUpperCase(),
                style: AppTextStyles.h3.copyWith(color: _avatarColor),
              ),
            ),

            Gap.w12,

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(consumer.name, style: AppTextStyles.h4),
                  Gap.h4,
                  Row(
                    children: [
                      Icon(Icons.badge_outlined, size: 12, color: AppColors.textHint),
                      Gap.w4,
                      Text(consumer.consumerNo, style: AppTextStyles.caption),
                    ],
                  ),
                  Gap.h2,
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 12, color: AppColors.textHint),
                      Gap.w4,
                      Expanded(
                        child: Text(
                          consumer.address,
                          style: AppTextStyles.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Pending Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warningLight,
                borderRadius: AppDimens.brFull,
              ),
              child: Text(
                "Pending",
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}