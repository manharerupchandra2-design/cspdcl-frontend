// // // import 'package:flutter/material.dart';
// // //
// // // class HistoryPage extends StatelessWidget {
// // //   const HistoryPage({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //
// // //
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //
// // //         child: Column(
// // //           children: [
// // //
// // //             TextField(
// // //               decoration: InputDecoration(
// // //                 hintText: "Search Consumer",
// // //                 prefixIcon: const Icon(Icons.search),
// // //
// // //                 border: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //               ),
// // //             ),
// // //
// // //             const SizedBox(height: 15),
// // //
// // //             Expanded(
// // //               child: ListView.builder(
// // //                 itemCount: 10,
// // //
// // //                 itemBuilder: (context, index) {
// // //                   return Card(
// // //                     margin: const EdgeInsets.only(bottom: 12),
// // //
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(12),
// // //                     ),
// // //
// // //                     child: ListTile(
// // //                       contentPadding:
// // //                       const EdgeInsets.all(12),
// // //
// // //                       leading: CircleAvatar(
// // //                         child: Text("${index + 1}"),
// // //                       ),
// // //
// // //                       title: const Text(
// // //                         "Rupchandra Manhare",
// // //                         style: TextStyle(
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //
// // //                       subtitle: Column(
// // //                         crossAxisAlignment:
// // //                         CrossAxisAlignment.start,
// // //                         children: const [
// // //
// // //                           SizedBox(height: 5),
// // //
// // //                           Text(
// // //                             "Consumer No : 10001234",
// // //                           ),
// // //
// // //                           SizedBox(height: 3),
// // //
// // //                           Text(
// // //                             "Reading : 1450",
// // //                           ),
// // //
// // //                           SizedBox(height: 3),
// // //
// // //                           Text(
// // //                             "02-Jun-2026",
// // //                           ),
// // //                         ],
// // //                       ),
// // //
// // //                       trailing: Container(
// // //                         padding:
// // //                         const EdgeInsets.symmetric(
// // //                           horizontal: 10,
// // //                           vertical: 5,
// // //                         ),
// // //
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.green.shade100,
// // //                           borderRadius:
// // //                           BorderRadius.circular(20),
// // //                         ),
// // //
// // //                         child: const Text(
// // //                           "Submitted",
// // //                         ),
// // //                       ),
// // //
// // //                       onTap: () {},
// // //                     ),
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:sample1/services/api_services.dart';
// //
// // import '../../controllers/consumer_controller/reading_history_controller.dart';
// //
// // class HistoryPage extends StatelessWidget {
// //   HistoryPage({super.key});
// //
// //   final controller = Get.put(HistoryController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return const Center(child: CircularProgressIndicator());
// //         }
// //
// //         if (controller.history.isEmpty) {
// //           return const Center(child: Text("No History Found"));
// //         }
// //
// //         return ListView.builder(
// //           itemCount: controller.history.length,
// //           itemBuilder: (context, index) {
// //             final item = controller.history[index];
// //
// //             return Card(
// //               margin: const EdgeInsets.all(8),
// //               child: ListTile(
// //                 leading: item.meterPhoto.isNotEmpty
// //                     ? Image.network(
// //                         "${ApiServices.baseUrl}/upload/${item.meterPhoto}",
// //                         width: 60,
// //                         height: 60,
// //                         fit: BoxFit.cover,
// //                       )
// //                     : const Icon(Icons.electric_meter),
// //
// //                 title: Text(item.consumerName),
// //
// //                 subtitle: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text("Consumer No : ${item.consumerNo}"),
// //                     Text("Meter No : ${item.meterNo}"),
// //                     Text("Reading : ${item.currentReading}"),
// //                     Text(item.createdAt),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       }),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../controllers/consumer_controller/reading_history_controller.dart';
// import '../../controllers/dashboard_controller/dashboard_controller.dart';
// import '../../core/theme/theme.dart';
//
// class HistoryPage extends StatelessWidget {
//   HistoryPage({super.key});
//
//   final controller = Get.put(HistoryController());
//   final ctrl = Get.find<DashboardController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           //Search Bar
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//             child: Column(
//               children: [
//                 AppTextField(
//                   label: "Search history...",
//                   prefixIcon: Icons.search,
//                   // onChanged: controller.search,
//                 ),
//                 Gap.h12,
//                 Obx(
//                   () => Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Total Readings", style: AppTextStyles.labelLarge),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.primary.withOpacity(0.1),
//                           borderRadius: AppDimens.brFull,
//                         ),
//                         child: Text(
//                           controller.filteredHistory.length.toString(),
//                           style: AppTextStyles.labelLarge.copyWith(
//                             color: AppColors.primary,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Gap.h12,
//                 Obx(
//                   () => Row(
//                     children: [
//                       // Date Filter Button
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () async {
//                             final picked = await showDatePicker(
//                               context: context,
//                               initialDate:
//                                   controller.selectedDate.value ??
//                                   DateTime.now(),
//                               firstDate: DateTime(2020),
//                               lastDate: DateTime.now(),
//                             );
//                             if (picked != null) {
//                               controller.onDateSelected(picked);
//                             }
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 10,
//                             ),
//                             decoration: BoxDecoration(
//                               color: controller.selectedDate.value != null
//                                   ? AppColors.primary.withOpacity(0.1)
//                                   : AppColors.surfaceVariant,
//                               borderRadius: AppDimens.br10,
//                               border: Border.all(color: AppColors.border),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.calendar_today_outlined,
//                                   size: 16,
//                                   color: controller.selectedDate.value != null
//                                       ? AppColors.primary
//                                       : AppColors.textHint,
//                                 ),
//                                 Gap.w8,
//                                 Text(
//                                   controller.selectedDate.value != null
//                                       ? DateFormat(
//                                           "dd MMM yyyy",
//                                         ).format(controller.selectedDate.value!)
//                                       : "Filter by date",
//                                   style: AppTextStyles.bodyMedium.copyWith(
//                                     color: controller.selectedDate.value != null
//                                         ? AppColors.primary
//                                         : AppColors.textHint,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // Clear button — sirf tab dikhe jab date select ho
//                       if (controller.selectedDate.value != null) ...[
//                         Gap.w8,
//                         GestureDetector(
//                           onTap: controller.clearFilter,
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: AppColors.errorLight,
//                               borderRadius: AppDimens.br10,
//                             ),
//                             child: const Icon(
//                               Icons.close,
//                               size: 16,
//                               color: AppColors.error,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // ── List ─────────────────────────────────────
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const LoadingState(message: "Loading....");
//               }
//
//               if (controller.history.isEmpty) {
//                 return const EmptyState(
//                   message: "Not found",
//                   icon: Icons.history_outlined,
//                 );
//               }
//
//               return ListView.builder(
//                 padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//                 itemCount: controller.filteredHistory.length,
//                 itemBuilder: (context, index) {
//                   final item = controller.filteredHistory[index];
//                   return _HistoryCard(item: item);
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── History Card ──────────────────────────────────────────
// class _HistoryCard extends StatelessWidget {
//   final dynamic item;
//   const _HistoryCard({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppCard(
//       padding: const EdgeInsets.all(12),
//       onTap: () {},
//       child: Row(
//         children: [
//           // ── Meter Photo ────────────────────────────
//           ClipRRect(
//             borderRadius: AppDimens.br10,
//             child: item.meterPhoto != null && item.meterPhoto!.isNotEmpty
//                 ? Image.network(
//                     item.meterPhoto!,
//                     width: 64,
//                     height: 64,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => _photoPlaceholder(),
//                     loadingBuilder: (_, child, progress) {
//                       if (progress == null) return child;
//                       return _photoPlaceholder(loading: true);
//                     },
//                   )
//                 : _photoPlaceholder(),
//           ),
//
//           Gap.w12,
//
//           // ── Info ───────────────────────────────────
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Name + Badge
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         item.consumerName,
//                         style: AppTextStyles.h4,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Gap.w8,
//                     const StatusBadge(
//                       status: "reading_done",
//                       label: "Submitted",
//                     ),
//                   ],
//                 ),
//                 Gap.h6,
//
//                 // Details
//                 _infoText(Icons.badge_outlined, "Consumer: ${item.consumerNo}"),
//                 Gap.h3,
//                 _infoText(
//                   Icons.electric_meter_outlined,
//                   "Meter: ${item.meterNo}",
//                 ),
//                 Gap.h3,
//                 _infoText(
//                   Icons.speed_outlined,
//                   "Reading: ${item.currentReading} kWh",
//                 ),
//                 Gap.h3,
//                 _infoText(
//                   Icons.calendar_today_outlined,
//                   DateFormat(
//                     "dd-MM-yyyy",
//                   ).format(DateTime.parse(item.createdAt)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoText(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 12, color: AppColors.textHint),
//         Gap.w4,
//         Expanded(
//           child: Text(
//             text,
//             style: AppTextStyles.caption,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _photoPlaceholder({bool loading = false}) {
//     return Container(
//       width: 64,
//       height: 64,
//       decoration: BoxDecoration(
//         color: AppColors.surfaceVariant,
//         borderRadius: AppDimens.br10,
//       ),
//       child: loading
//           ? const Center(
//               child: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               ),
//             )
//           : const Icon(
//               Icons.electric_meter_outlined,
//               color: AppColors.textHint,
//               size: 28,
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/consumer_controller/bill_history_controller.dart';
import '../../controllers/consumer_controller/reading_history_controller.dart';
import '../../core/theme/theme.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final historyCtrl = Get.put(HistoryController());
  final billCtrl = Get.put(BillHistoryController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            // ── Tab Bar ─────────────────────────────
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: AppDimens.br10,
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppDimens.br10,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: "Readings"),
                  Tab(text: "Bills"),
                ],
              ),
            ),

            Gap.h12,

            // ── Tab Views ───────────────────────────
            Expanded(
              child: TabBarView(
                children: [
                  _ReadingsTab(controller: historyCtrl),
                  _BillsTab(controller: billCtrl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Readings Tab ─────────────────────────────────────────
class _ReadingsTab extends StatelessWidget {
  final HistoryController controller;
  const _ReadingsTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search + Date Filter
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Column(
            children: [
              AppTextField(
                label: "Search history...",
                prefixIcon: Icons.search,
              ),
              Gap.h12,
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Readings", style: AppTextStyles.labelLarge),
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
                        controller.filteredHistory.length.toString(),
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap.h12,
              _DateFilter(
                selectedDate: controller.selectedDate,
                onDateSelected: controller.onDateSelected,
                onClear: controller.clearFilter,
                context: context,
              ),
            ],
          ),
        ),

        // List
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const LoadingState(message: "Loading....");
            }
            if (controller.filteredHistory.isEmpty) {
              return const EmptyState(
                message: "No readings found",
                icon: Icons.history_outlined,
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: controller.filteredHistory.length,
              itemBuilder: (context, index) {
                final item = controller.filteredHistory[index];
                return _HistoryCard(item: item);
              },
            );
          }),
        ),
      ],
    );
  }
}

// ── Bills Tab ────────────────────────────────────────────
class _BillsTab extends StatelessWidget {
  final BillHistoryController controller;
  const _BillsTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Column(
            children: [
              AppTextField(label: "Search bills...", prefixIcon: Icons.search),
              Gap.h12,
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Bills", style: AppTextStyles.labelLarge),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: AppDimens.brFull,
                      ),
                      child: Text(
                        controller.filteredBills.length.toString(),
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap.h12,
              _DateFilter(
                selectedDate: controller.selectedDate,
                onDateSelected: controller.onDateSelected,
                onClear: controller.clearFilter,
                context: context,
              ),
            ],
          ),
        ),

        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const LoadingState(message: "Loading....");
            }
            if (controller.filteredBills.isEmpty) {
              return const EmptyState(
                message: "No bills found",
                icon: Icons.receipt_outlined,
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: controller.filteredBills.length,
              itemBuilder: (context, index) {
                final item = controller.filteredBills[index];
                return _BillCard(item: item);
              },
            );
          }),
        ),
      ],
    );
  }
}

// ── Date Filter Widget ───────────────────────────────────
class _DateFilter extends StatelessWidget {
  final Rxn<DateTime> selectedDate;
  final Function(DateTime) onDateSelected;
  final VoidCallback onClear;
  final BuildContext context;

  const _DateFilter({
    required this.selectedDate,
    required this.onDateSelected,
    required this.onClear,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate.value ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) onDateSelected(picked);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selectedDate.value != null
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.surfaceVariant,
                  borderRadius: AppDimens.br10,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: selectedDate.value != null
                          ? AppColors.primary
                          : AppColors.textHint,
                    ),
                    Gap.w8,
                    Text(
                      selectedDate.value != null
                          ? DateFormat(
                              "dd MMM yyyy",
                            ).format(selectedDate.value!)
                          : "Filter by date",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: selectedDate.value != null
                            ? AppColors.primary
                            : AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (selectedDate.value != null) ...[
            Gap.w8,
            GestureDetector(
              onTap: onClear,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.errorLight,
                  borderRadius: AppDimens.br10,
                ),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: AppColors.error,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Bill Card ────────────────────────────────────────────
class _BillCard extends StatelessWidget {
  final dynamic item;
  const _BillCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      onTap: () {},
      child: Row(
        children: [
          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: AppDimens.br10,
            ),
            child: const Icon(
              Icons.receipt_long,
              color: AppColors.success,
              size: 28,
            ),
          ),

          Gap.w12,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    Text(
                      "₹ ${item.amount.toStringAsFixed(2)}",
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                Gap.h6,
                _infoText(Icons.badge_outlined, "Consumer: ${item.consumerNo}"),
                Gap.h3,
                _infoText(
                  Icons.electric_meter_outlined,
                  "Meter: ${item.meterNo}",
                ),
                Gap.h3,
                _infoText(Icons.speed_outlined, "Units: ${item.units} kWh"),
                Gap.h3,
                _infoText(
                  Icons.calendar_today_outlined,
                  DateFormat(
                    "dd-MM-yyyy",
                  ).format(DateTime.parse(item.createdAt)),
                ),
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
}

// ── History Card (same as before) ────────────────────────
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                _infoText(
                  Icons.calendar_today_outlined,
                  DateFormat(
                    "dd-MM-yyyy",
                  ).format(DateTime.parse(item.createdAt)),
                ),
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
