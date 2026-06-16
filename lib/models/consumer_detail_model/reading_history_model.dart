class ReadingHistoryResponse {
  final bool success;
  final List<ReadingHistoryItem> data;

  ReadingHistoryResponse({required this.success, required this.data});

  factory ReadingHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ReadingHistoryResponse(
      success: json["success"],
      data: (json["data"] as List).map((e) => ReadingHistoryItem.fromJson(e)).toList(),
    );
  }
}

class ReadingHistoryItem {
  final int id;
  final String consumerName;
  final String consumerNo;
  final String meterNo;
  final int currentReading;
  final String? meterPhoto;
  final String createdAt;

  ReadingHistoryItem({
    required this.id,
    required this.consumerName,
    required this.consumerNo,
    required this.meterNo,
    required this.currentReading,
    required this.meterPhoto,
    required this.createdAt,
  });

  factory ReadingHistoryItem.fromJson(Map<String, dynamic> json) {
    return ReadingHistoryItem(
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
