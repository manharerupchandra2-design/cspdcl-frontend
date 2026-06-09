
import 'meter_reader_model/meter_reader_model.dart';

class LoginResponse {
  final bool success;
  final String message;
  final String? token;
  final MeterReaderModel? meterReader;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
    this.meterReader,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "Error",
      token: json['token'] ?? "",
      meterReader: json['user']!=null?MeterReaderModel.fromJson(json['user']):null,
    );
  }
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
