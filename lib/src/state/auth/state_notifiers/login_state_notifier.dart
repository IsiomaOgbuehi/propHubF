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
          ref.read(akuStorageProvider).setAuthToken(right.token),
          ref.read(akuStorageProvider).setUserId(right.userResponse.userId),
          ref.read(akuStorageProvider).setFirstname(right.userResponse.firstname),
          ref.read(akuStorageProvider).setLastname(right.userResponse.lastname),
          ref.read(akuStorageProvider).setUserEmail(right.userResponse.email),
          ref.read(akuStorageProvider).setPhone(right.userResponse.phone),
          ref.read(akuStorageProvider).setUserType(right.userResponse.userType),
          ref.read(akuStorageProvider).setUserState(right.userResponse.state),
          ref.read(akuStorageProvider).setUserLga(right.userResponse.lga),
        ]);
      }

      state = model.emit(result.fold((left) => state.copyWith(viewState: ViewState.error, error: left), (right) {
        ref.read(userDataProvider.notifier).updateUserData(right.userResponse);
        return state.copyWith(viewState: ViewState.success);
      }));
    });
  }
}
