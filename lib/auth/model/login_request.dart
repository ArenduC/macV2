class LoginRequest {
  final String email;
  final String password;
  final String accessToken;

  LoginRequest({
    required this.email,
    required this.password,
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'accessToken': accessToken,
    };
  }
}
