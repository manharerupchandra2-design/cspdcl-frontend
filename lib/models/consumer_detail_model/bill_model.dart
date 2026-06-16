import 'package:intl/intl.dart';

class BillResponse {
  final bool success;
  final String message;
  final BillData data;

  BillResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BillResponse.fromJson(Map<String, dynamic> json) {
    return BillResponse(
      success: json['success'],
      message: json['message'],
      data: BillData.fromJson(json['data']),
    );
  }
}

class BillData {
  final int billId;
  final String consumerName;
  final String consumerNo;
  final String consumerMobile;
  final String meterNo;

  final int previousReading;
  final int currentReading;
  final int units;

  final String calculatedAmount;
  final String discountAmount;
  final int fixed;
  final String amount;
  final String totalAmount;

  final DateTime dueDate;
  BillData({
    required this.billId,
    required this.consumerName,
    required this.consumerNo,
    required this.consumerMobile,
    required this.meterNo,
    required this.previousReading,
    required this.currentReading,
    required this.units,
    required this.calculatedAmount,
    required this.discountAmount,
    required this.fixed,
    required this.amount,
    required this.totalAmount,
    required this.dueDate,
  });

  factory BillData.fromJson(Map<String, dynamic> json) {
    return BillData(
      billId: json['bill_id'],
      consumerName: json['consumer_name'],
      consumerNo: json['consumer_no'],
      consumerMobile: json['consumer_mobile'],
      meterNo: json['meter_no'],
      previousReading: json['previous_reading'],
      currentReading: json['current_reading'],
      units: json['units'],
      calculatedAmount: json['calculatedAmount'].toString(),
      discountAmount: json['discountAmount'].toString(),
      fixed: json['fixed'],
      amount: json['amount'].toString(),
      totalAmount: json['totalAmount'].toString(),
      dueDate: (DateTime.parse((json['dueDate']))),
    );
  }
}
