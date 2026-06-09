class MeterReaderModel {
  final int id;
  final String name;
  final String email;
  final String mobile;

  MeterReaderModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory MeterReaderModel.fromJson(Map<String, dynamic> json) {
    return MeterReaderModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
    );
  }
}
