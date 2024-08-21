import 'package:equatable/equatable.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';


typedef PropHubViewModelRef<T extends PropHubViewModel> = List<T>;

enum ViewState { idle, loading, success, error, paymentRequired }

abstract class PropHubViewModel extends Equatable {
  const PropHubViewModel();

  ViewState get viewState;

  PropHubExceptions get error;

  @override
  bool? get stringify => true;
}

Future<void> launch<E extends PropHubViewModel>(
    PropHubViewModelRef<E> model,
    Future<void> Function(PropHubViewModelRef<E> model) function, {
      bool displayError = true,
      ErrorConfiguration? configuration = const ErrorConfiguration(),
    }) async {
  assert(
  !displayError || (displayError && configuration != null),
  'When display error is true, please provide an error configuration.',
  );
  await Future.sync(() => function(model));

  if (model.isEmpty || !displayError) return;
  model._state.displayError(configuration ?? const ErrorConfiguration());
}

class ErrorConfiguration {
  final String? title;
  final bool isDismissible;
  final bool isRestriction;

  const ErrorConfiguration({
    this.title,
    this.isDismissible = true,
    this.isRestriction = false,
  });
}

extension PropHubViewModelX<T extends PropHubViewModel> on T {
  PropHubViewModelRef<T> get reference => [this];

  void displayError([
    ErrorConfiguration configuration = const ErrorConfiguration(),
  ]) async {
    if (viewState != ViewState.error) return;

    // final context = Routes.navigatorKey.currentContext!;
    // context.showMessage(
    //   type: MessageType.error,
    //   title: configuration.title,
    //   subtitle: error.message,
    //   isDismissible: configuration.isDismissible,
    //   isRestriction: configuration.isRestriction,
    // );
  }
}

extension PropHubViewModelRefX<T extends PropHubViewModel> on PropHubViewModelRef<T> {
  PropHubViewModelRef<T> _assign(T value) {
    this[0] = value;
    return this;
  }

  T get _state => this[0];

  T emit(T value) => _assign(value)._state;
}
