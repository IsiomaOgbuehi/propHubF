import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/state/auth/view_state/user_info_view_state.dart';
import '../view_models/response/user_response.dart';

final userDataProvider = StateNotifierProvider<AppUserStateNotifier, UserInfo>((ref) => AppUserStateNotifier(ref));

class AppUserStateNotifier extends StateNotifier<UserInfo> {
  final StateNotifierProviderRef ref;
  AppUserStateNotifier(this.ref) : super(UserInfo.initial());

  void updateUserData(UserResponse user) {
    state = state.copyWith(userData: user);
  }
}
