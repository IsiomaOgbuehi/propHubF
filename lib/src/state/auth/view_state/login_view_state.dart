import 'package:prophub/src/domain/core/prophub_view_model.dart';
import 'package:prophub/src/domain/entities/auth/login_entity.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';

class LoginViewState extends PropHubViewUiState<LoginViewState> {
  @override
  final PropHubExceptions error;
  @override
  final ViewState viewState;
  final bool showFormErrors;
  final LoginEntity loginForm;

  const LoginViewState(
      {required this.error, required this.viewState, required this.showFormErrors, required this.loginForm});

  factory LoginViewState.initial() => LoginViewState(
      error: const EmptyException(),
      viewState: ViewState.idle,
      showFormErrors: false,
      loginForm: LoginEntity.initial());

  @override
  LoginViewState copyWith(
          {PropHubExceptions? error, ViewState? viewState, bool? showFormErrors, LoginEntity? loginForm}) =>
      LoginViewState(
          error: error ?? this.error,
          viewState: viewState ?? this.viewState,
          showFormErrors: showFormErrors ?? this.showFormErrors,
          loginForm: loginForm ?? this.loginForm);

  @override
  List<Object?> get props => [error, viewState, showFormErrors, loginForm];
}
