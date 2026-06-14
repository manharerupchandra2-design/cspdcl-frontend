class SignupResponse {
  final bool success;
  final String message;

  SignupResponse({required this.success, required this.message});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
    );
  }
}

class SignupRequest {
  final String email;
  final String password;
  final String name;
  final String mobile;
  final String zone;

  SignupRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.mobile,
    required this.zone,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "name": name,
      "mobile": mobile,
      "zone": zone,
    };
  }
}
