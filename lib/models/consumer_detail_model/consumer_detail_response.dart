import 'consumer_detail_data.dart';

class ConsumerDetailResponse {
  final bool success;
  final String message;
  final ConsumerDetailData data;

  ConsumerDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ConsumerDetailResponse.fromJson(
      Map<String, dynamic> json) {
    return ConsumerDetailResponse(
      success: json['success'],
      message: json['message'],
      data: ConsumerDetailData.fromJson(
        json['data'],
      ),
    );
  }
}