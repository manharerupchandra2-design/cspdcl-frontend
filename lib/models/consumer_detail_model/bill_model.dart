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
  final String meterNo;

  final int previousReading;
  final int currentReading;
  final int units;

  final double amount;

  BillData({
    required this.billId,
    required this.consumerName,
    required this.consumerNo,
    required this.meterNo,
    required this.previousReading,
    required this.currentReading,
    required this.units,
    required this.amount,
  });

  factory BillData.fromJson(Map<String, dynamic> json) {
    return BillData(
      billId: json['bill_id'],
      consumerName: json['consumer_name'],
      consumerNo: json['consumer_no'],
      meterNo: json['meter_no'],
      previousReading: json['previous_reading'],
      currentReading: json['current_reading'],
      units: json['units'],
      amount: double.parse(json['amount'].toString()),
    );
  }
}
