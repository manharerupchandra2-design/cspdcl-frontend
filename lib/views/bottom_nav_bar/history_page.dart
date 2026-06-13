// // import 'package:flutter/material.dart';
// //
// // class HistoryPage extends StatelessWidget {
// //   const HistoryPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //
// //
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //
// //         child: Column(
// //           children: [
// //
// //             TextField(
// //               decoration: InputDecoration(
// //                 hintText: "Search Consumer",
// //                 prefixIcon: const Icon(Icons.search),
// //
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //               ),
// //             ),
// //
// //             const SizedBox(height: 15),
// //
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: 10,
// //
// //                 itemBuilder: (context, index) {
// //                   return Card(
// //                     margin: const EdgeInsets.only(bottom: 12),
// //
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //
// //                     child: ListTile(
// //                       contentPadding:
// //                       const EdgeInsets.all(12),
// //
// //                       leading: CircleAvatar(
// //                         child: Text("${index + 1}"),
// //                       ),
// //
// //                       title: const Text(
// //                         "Rupchandra Manhare",
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //
// //                       subtitle: Column(
// //                         crossAxisAlignment:
// //                         CrossAxisAlignment.start,
// //                         children: const [
// //
// //                           SizedBox(height: 5),
// //
// //                           Text(
// //                             "Consumer No : 10001234",
// //                           ),
// //
// //                           SizedBox(height: 3),
// //
// //                           Text(
// //                             "Reading : 1450",
// //                           ),
// //
// //                           SizedBox(height: 3),
// //
// //                           Text(
// //                             "02-Jun-2026",
// //                           ),
// //                         ],
// //                       ),
// //
// //                       trailing: Container(
// //                         padding:
// //                         const EdgeInsets.symmetric(
// //                           horizontal: 10,
// //                           vertical: 5,
// //                         ),
// //
// //                         decoration: BoxDecoration(
// //                           color: Colors.green.shade100,
// //                           borderRadius:
// //                           BorderRadius.circular(20),
// //                         ),
// //
// //                         child: const Text(
// //                           "Submitted",
// //                         ),
// //                       ),
// //
// //                       onTap: () {},
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sample1/services/api_services.dart';
//
// import '../../controllers/consumer_controller/history_controller.dart';
//
// class HistoryPage extends StatelessWidget {
//   HistoryPage({super.key});
//
//   final controller = Get.put(HistoryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.history.isEmpty) {
//           return const Center(child: Text("No History Found"));
//         }
//
//         return ListView.builder(
//           itemCount: controller.history.length,
//           itemBuilder: (context, index) {
//             final item = controller.history[index];
//
//             return Card(
//               margin: const EdgeInsets.all(8),
//               child: ListTile(
//                 leading: item.meterPhoto.isNotEmpty
//                     ? Image.network(
//                         "${ApiServices.baseUrl}/upload/${item.meterPhoto}",
//                         width: 60,
//                         height: 60,
//                         fit: BoxFit.cover,
//                       )
//                     : const Icon(Icons.electric_meter),
//
//                 title: Text(item.consumerName),
//
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Consumer No : ${item.consumerNo}"),
//                     Text("Meter No : ${item.meterNo}"),
//                     Text("Reading : ${item.currentReading}"),
//                     Text(item.createdAt),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/consumer_controller/history_controller.dart';
import '../../core/theme/theme.dart'; // ✅ ek import

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getHistory();
    });
    return Scaffold(
      body: Column(
        children: [
          // ── Search Bar ────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: AppTextField(
              label: "Search history...",
              prefixIcon: Icons.search,
              // onChanged: controller.search, // controller mein method banao
            ),
          ),

          // ── List ─────────────────────────────────────
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const LoadingState(message: "Loading....");
              }

              if (controller.history.isEmpty) {
                return const EmptyState(
                  message: "Not found",
                  icon: Icons.history_outlined,
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: controller.history.length,
                itemBuilder: (context, index) {
                  final item = controller.history[index];
                  return _HistoryCard(item: item);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── History Card ──────────────────────────────────────────
class _HistoryCard extends StatelessWidget {
  final dynamic item;
  const _HistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      onTap: () {},
      child: Row(
        children: [
          // ── Meter Photo ────────────────────────────
          ClipRRect(
            borderRadius: AppDimens.br10,
            child: item.meterPhoto != null && item.meterPhoto!.isNotEmpty
                ? Image.network(
                    item.meterPhoto!,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _photoPlaceholder(),
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return _photoPlaceholder(loading: true);
                    },
                  )
                : _photoPlaceholder(),
          ),

          Gap.w12,

          // ── Info ───────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.consumerName,
                        style: AppTextStyles.h4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Gap.w8,
                    const StatusBadge(
                      status: "reading_done",
                      label: "Submitted",
                    ),
                  ],
                ),
                Gap.h6,

                // Details
                _infoText(Icons.badge_outlined, "Consumer: ${item.consumerNo}"),
                Gap.h3,
                _infoText(
                  Icons.electric_meter_outlined,
                  "Meter: ${item.meterNo}",
                ),
                Gap.h3,
                _infoText(
                  Icons.speed_outlined,
                  "Reading: ${item.currentReading} kWh",
                ),
                Gap.h3,
                _infoText(Icons.calendar_today_outlined, item.createdAt),
              ],
            ),
          ),
        ],
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

  Widget _photoPlaceholder({bool loading = false}) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppDimens.br10,
      ),
      child: loading
          ? const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : const Icon(
              Icons.electric_meter_outlined,
              color: AppColors.textHint,
              size: 28,
            ),
    );
  }
}
