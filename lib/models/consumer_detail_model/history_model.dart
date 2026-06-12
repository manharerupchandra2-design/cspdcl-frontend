class HistoryResponse {
  final bool success;
  final List<HistoryItem> data;

  HistoryResponse({
    required this.success,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      success: json["success"],
      data: (json["data"] as List)
          .map((e) => HistoryItem.fromJson(e))
          .toList(),
    );
  }
}

class HistoryItem {
  final int id;
  final String consumerName;
  final String consumerNo;
  final String meterNo;
  final int currentReading;
  final String? meterPhoto;
  final String createdAt;

  HistoryItem({
    required this.id,
    required this.consumerName,
    required this.consumerNo,
    required this.meterNo,
    required this.currentReading,
    required this.meterPhoto,
    required this.createdAt,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json["id"],
      consumerName: json["consumer_name"] ?? "",
      consumerNo: json["consumer_no"] ?? "",
      meterNo: json["meter_no"] ?? "",
      currentReading: json["current_reading"] ?? 0,
      meterPhoto: json["meter_photo"],
      createdAt: json["created_at"] ?? "",
    );
  }
}