class CommonResModel {
  final bool success;
  final String message;

  CommonResModel({required this.success,required this.message});

  factory CommonResModel.fromJson(Map<String,dynamic>json){
    return CommonResModel(success: json['success'], message: json['message']);
  }
}