import 'package:prophub/src/state/auth/view_models/response/user_response.dart';

class LoginResponse {
  final String token;
  final UserResponse userResponse;

  const LoginResponse({required this.token, required this.userResponse});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(token: json['token'], userResponse: UserResponse.fromJson(json['user']));
}
