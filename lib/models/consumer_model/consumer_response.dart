import 'consumer_data.dart';

class ConsumerResponse {
  final bool success;
  final String message;
  final ConsumerData data;

  ConsumerResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ConsumerResponse.fromJson(
      Map<String, dynamic> json) {
    return ConsumerResponse(
      success: json['success'],
      message: json['message'],
      data: ConsumerData.fromJson(json['data']),
    );
  }
}