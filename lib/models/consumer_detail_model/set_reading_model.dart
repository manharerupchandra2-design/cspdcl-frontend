import 'dart:io';

class SetReadingRequest {
  final int meterId;
  final int readerId;
  final int currentReading;
  final File? meterPhoto;

  SetReadingRequest({
    required this.meterId,
    required this.readerId,
    required this.currentReading,
    this.meterPhoto,
  });

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