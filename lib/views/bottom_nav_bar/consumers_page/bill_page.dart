import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/bottom_nav_controller/bottom_nav_controller.dart';
import '../../../controllers/dashboard_controller/dashboard_controller.dart';
import '../../../core/theme/theme.dart';
import '../../../models/consumer_detail_model/bill_model.dart';
import '../home_page.dart';

class GeneratedBillPage extends StatefulWidget {
  final BillData bill;
  const GeneratedBillPage({super.key, required this.bill});

  @override
  State<GeneratedBillPage> createState() => _GeneratedBillPageState();
}

class _GeneratedBillPageState extends State<GeneratedBillPage> {
  Future<void> _sendSMS() async {
    final mobile = widget.bill.consumerMobile.replaceAll(RegExp(r'[^0-9]'), '');

    final body =
        "CSPDCL Electricity Bill\n"
        "Consumer: ${widget.bill.consumerName}\n"
        "Consumer No: ${widget.bill.consumerNo}\n"
        "Units: ${widget.bill.units} kWh\n"
        "Amount: Rs ${widget.bill.amount}\n"
        "Due Date: ${widget.bill.dueDate}"
        "Please pay before due date.";

    // smsto:
    final Uri smsUri = Uri.parse(
      "smsto:$mobile?body=${Uri.encodeComponent(body)}",
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri, mode: LaunchMode.externalApplication);
    } else {
      final Uri fallback = Uri.parse("sms:$mobile");
      try {
        await launchUrl(fallback, mode: LaunchMode.externalApplication);
      } catch (e) {
        Get.snackbar("Error", "SMS not found — send manually: $mobile");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bill Receipt")),

      body: SingleChildScrollView(
        padding: AppDimens.pagePadding,
        child: Column(
          children: [
            //Success Banner
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
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Gap.w14,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bill Generated!", style: AppTextStyles.onPrimaryH2),
                      Gap.h4,
                      Text(
                        "Successfully submitted",
                        style: AppTextStyles.onPrimaryBody,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Gap.h16,

            //Bill Header
            AppCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.electric_bolt,
                        color: AppColors.accent,
                        size: 20,
                      ),
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
                        Text("Total Amount", style: AppTextStyles.labelLarge),
                        Gap.h6,
                        Text(
                          "₹ ${widget.bill.totalAmount}",
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

            //Consumer Info
            InfoCard(
              title: "Consumer Information",
              titleIcon: Icons.person_outline,
              rows: [
                InfoRow("Consumer", widget.bill.consumerName),
                InfoRow("Consumer No", widget.bill.consumerNo),
                InfoRow("Meter No", widget.bill.meterNo),
              ],
            ),

            Gap.h12,

            //Reading Info
            InfoCard(
              title: "Reading Details",
              titleIcon: Icons.speed_outlined,
              rows: [
                InfoRow(
                  "Previous Reading",
                  "${widget.bill.previousReading} kWh",
                ),
                InfoRow("Current Reading", "${widget.bill.currentReading} kWh"),
                InfoRow(
                  "Units Consumed",
                  "${widget.bill.units} units",
                  valueColor: AppColors.info,
                ),
                InfoRow(
                  "Calculated Amount",
                  "${widget.bill.calculatedAmount} ₹",
                ),
                InfoRow("Discount", "${widget.bill.discountAmount} ₹"),
                InfoRow(
                  "Bill Amount",
                  "₹ ${widget.bill.amount}",
                  valueColor: AppColors.success,
                ),
                InfoRow("Fixed Charge", "+${widget.bill.fixed} ₹"),
                InfoRow(
                  "Due Date",
                  "${DateFormat("dd MMM yyyy").format(widget.bill.dueDate)}",
                ),
              ],
            ),

            Gap.h24,

            //Buttons
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
              onPressed: _sendSMS,
            ),

            Gap.h20,
          ],
        ),
      ),
    );
  }
}
