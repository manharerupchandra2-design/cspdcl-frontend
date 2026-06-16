class BillHistoryResponse {
  final bool success;
  final List<BillHistoryItem> data;

  BillHistoryResponse({required this.success, required this.data});

  factory BillHistoryResponse.fromJson(Map<String, dynamic> json) {
    return BillHistoryResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((e) => BillHistoryItem.fromJson(e))
          .toList(),
    );
  }
}

class BillHistoryItem {
  final int billId;
  final double amount;
  final String createdAt;
  final String consumerName;
  final String consumerNo;
  final String meterNo;
  final int previousReading;
  final int currentReading;
  final int units;

  BillHistoryItem({
    required this.billId,
    required this.amount,
    required this.createdAt,
    required this.consumerName,
    required this.consumerNo,
    required this.meterNo,
    required this.previousReading,
    required this.currentReading,
    required this.units,
  });

  factory BillHistoryItem.fromJson(Map<String, dynamic> json) {
    return BillHistoryItem(
      billId: json['bill_id'],
      amount: double.parse(json['amount'].toString()),
      createdAt: json['created_at'] ?? '',
      consumerName: json['consumer_name'] ?? '',
      consumerNo: json['consumer_no'] ?? '',
      meterNo: json['meter_no'] ?? '',
      previousReading: json['previous_reading'] ?? 0,
      currentReading: json['current_reading'] ?? 0,
      units: json['units'] ?? 0,
    );
  }
}