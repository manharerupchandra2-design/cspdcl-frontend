import 'consumer_detail.dart';
import 'previous_bill.dart';

class ConsumerDetailData {
  final ConsumerDetail consumer;

  final PreviousBill? previousBill;

  ConsumerDetailData({
    required this.consumer,
    this.previousBill,
  });

  factory ConsumerDetailData.fromJson(
      Map<String, dynamic> json) {
    return ConsumerDetailData(
      consumer: ConsumerDetail.fromJson(
        json['consumer'],
      ),

      previousBill:
      json['previous_bill'] == null
          ? null
          : PreviousBill.fromJson(
        json['previous_bill'],
      ),
    );
  }
}