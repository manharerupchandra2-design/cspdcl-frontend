class SetReadingRequest {
  final int meterId;
  final int readerId;
  final int currentReading;
  final String meterPhoto;

  SetReadingRequest({
    required this.meterId,
    required this.readerId,
    required this.currentReading,
    required this.meterPhoto,
  });

  Map<String, dynamic> toJson() {
    return {
      "meter_id": meterId,
      "reader_id": readerId,
      "current_reading": currentReading,
      "meter_photo": meterPhoto,
    };
  }
}

class SetReadingResponse {
  final bool success;
  final String message;
  final int readingId;

  SetReadingResponse({
    required this.success,
    required this.message,
    required this.readingId,
  });

  factory SetReadingResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return SetReadingResponse(
      success: json['success'],
      message: json['message'],
      readingId: json['reading_id'],
    );
  }
}