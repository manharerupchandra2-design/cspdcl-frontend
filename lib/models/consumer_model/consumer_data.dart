import 'consumer_model.dart';

class ConsumerData {
  final int totalConsumers;
  final List<Consumer> consumers;

  ConsumerData({
    required this.totalConsumers,
    required this.consumers,
  });

  factory ConsumerData.fromJson(
      Map<String, dynamic> json) {
    return ConsumerData(
      totalConsumers: json['total_consumers'],
      consumers: (json['consumers'] as List)
          .map((e) => Consumer.fromJson(e))
          .toList(),
    );
  }
}