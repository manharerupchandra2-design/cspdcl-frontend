class ConsumerDetail {
  final int id;

  final String consumerNo;
  final String name;
  final String mobile;
  final String address;

  final int meterId;
  final String meterNo;
  final String meterType;

  ConsumerDetail({
    required this.id,
    required this.consumerNo,
    required this.name,
    required this.mobile,
    required this.address,
    required this.meterId,
    required this.meterNo,
    required this.meterType,
  });

  factory ConsumerDetail.fromJson(
      Map<String, dynamic> json) {
    return ConsumerDetail(
      id: json['id'],
      consumerNo: json['consumer_no'],
      name: json['name'],
      mobile: json['mobile'],
      address: json['address'],
      meterId: json['meter_id'],
      meterNo: json['meter_no'],
      meterType: json['meter_type'],
    );
  }
}