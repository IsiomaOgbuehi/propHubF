import 'package:prophub/src/state/auth/view_models/response/user_response.dart';

class UserInfo {
  final UserResponse userData;
  UserInfo({required this.userData});

  factory UserInfo.initial() => UserInfo(userData: UserResponse.init());

  UserInfo copyWith({UserResponse? userData}) => UserInfo(userData: userData ?? this.userData);
}