import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/domain/core/prophub_view_model.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/state/auth/data_provider/auth_data_provider.dart';
import 'package:prophub/src/state/auth/view_state/login_view_state.dart';
import 'package:prophub/src/utilities/storage/app_storage.dart';

import 'app_user_state_notifier.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<LoginStateNotifier, LoginViewState>((ref) => LoginStateNotifier(ref));

class LoginStateNotifier extends StateNotifier<LoginViewState> {
  final StateNotifierProviderRef ref;
  LoginStateNotifier(this.ref) : super(LoginViewState.initial());

  void onChangeEmail(String input) {
    state = state.copyWith(loginForm: state.loginForm.copyWith(email: Email(input)));
  }

  void onChangePassword(String input) {
    state = state.copyWith(loginForm: state.loginForm.copyWith(password: Password(input)));
  }

  void loginBtnOnTap() async {
    await launch(state.reference, (model) async {
      state = state.copyWith(viewState: ViewState.loading);
      final result = await ref.refresh(userLoginProvider(state.loginForm).future);

      if (result.isRight) {
        final right = result.right;
        await Future.wait([
          ref.read(propHubStorageProvider).setAuthToken(right.token),
          ref.read(propHubStorageProvider).setUserId(right.userResponse.userId),
          ref.read(propHubStorageProvider).setFirstname(right.userResponse.firstname),
          ref.read(propHubStorageProvider).setLastname(right.userResponse.lastname),
          ref.read(propHubStorageProvider).setUserEmail(right.userResponse.email),
          ref.read(propHubStorageProvider).setPhone(right.userResponse.phone),
          ref.read(propHubStorageProvider).setUserType(right.userResponse.userType),
          ref.read(propHubStorageProvider).setUserState(right.userResponse.state),
          ref.read(propHubStorageProvider).setUserLga(right.userResponse.lga),
        ]);
      }

      state = model.emit(result.fold((left) => state.copyWith(viewState: ViewState.error, error: left), (right) {
        ref.read(userDataProvider.notifier).updateUserData(right.userResponse);
        return state.copyWith(viewState: ViewState.success);
      }));
    });
  }
}
