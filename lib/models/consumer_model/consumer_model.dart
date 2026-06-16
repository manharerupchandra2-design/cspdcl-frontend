class Consumer {
  final int? id;
  final String? consumerNo;
  final String? name;
  final String? mobile;
  final String? address;

  final int? meterId;
  final String? meterNo;
  final String? meterType;

  Consumer({
     this.id,
     this.consumerNo,
     this.name,
     this.mobile,
     this.address,
    this.meterId,
    this.meterNo,
    this.meterType,
  });

  factory Consumer.fromJson(Map<String, dynamic> json) {
    return Consumer(
      id: json['id'],
      consumerNo: json['consumer_no']??"No consumer number",
      name: json['name']??"No name",
      mobile: json['mobile']??"No mobile ",
      address: json['address']??"No Address",
      meterId: json['meter_id'],
      meterNo: json['meter_no']??"null",
      meterType: json['meter_type']??"null",
    );
  }
}
