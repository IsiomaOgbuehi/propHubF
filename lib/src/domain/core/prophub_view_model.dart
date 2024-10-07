import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';


typedef PropHubViewModelRef<T extends PropHubViewUiState <T>> = List<T>;

enum ViewState { idle, loading, success, error, paymentRequired }

// abstract class PropHubViewModel<T extends PropHubViewUiState<T>> extends Equatable {
//   const PropHubViewModel();
//
//   ViewState get viewState;
//
//   PropHubExceptions get error;
//
//   @override
//   bool? get stringify => true;
// }

Future<void> launch<E extends PropHubViewUiState<E>>(
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

extension PropHubViewModelX<T extends PropHubViewUiState<T>> on T {
  PropHubViewModelRef<T> get reference => [this];

  void displayError([
    ErrorConfiguration configuration = const ErrorConfiguration(),
  ]) async {
    if (viewState != ViewState.error) return;

    T emitTo(PropHubViewModelRef<T> model) {
      return model.emit(this);
    }

    T reset() {
      return copyWith(
        viewState: ViewState.idle,
        error: const EmptyException(),
      );
    }

    T sError(PropHubExceptions error) {
      return copyWith(
        viewState: ViewState.error,
        error: error,
      );
    }

    T sSuccess() {
      return copyWith(viewState: ViewState.success);
    }

    T sLoading() {
      return copyWith(viewState: ViewState.loading);
    }

    T sPaymentRequired() {
      return copyWith(viewState: ViewState.paymentRequired);
    }

    void displayError([
      ErrorConfiguration configuration = const ErrorConfiguration(),
    ]) async {
      if (viewState != ViewState.error || error is EmptyException) return;
    }
  }
}

extension PropHubViewModelRefX<T extends PropHubViewUiState<T>> on PropHubViewModelRef<T> {
  PropHubViewModelRef<T> _assign(T value) {
    this[0] = value;
    return this;
  }

  T get _state => this[0];

  T emit(T value) => _assign(value)._state;
}

@immutable
abstract class PropHubViewUiState<T extends PropHubViewUiState<T>> extends Equatable {
  const PropHubViewUiState();

  ViewState get viewState;

  PropHubExceptions get error;

  T copyWith({
    ViewState? viewState,
    PropHubExceptions? error,
  });

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [viewState, error];
}

@immutable
abstract base class PropHubViewFormUiState<T extends PropHubViewFormUiState<T>> extends PropHubViewUiState<T> {
  const PropHubViewFormUiState();

  bool get showFormErrors;

  @override
  T copyWith({
    ViewState? viewState,
    PropHubExceptions? error,
    bool? showFormErrors,
  });

  @override
  List<Object?> get props => [...super.props, showFormErrors];
}

extension PropHubFormViewUiX<T extends PropHubViewFormUiState<T>> on T {
  T toggleFormErrors([bool? showFormError]) {
    return copyWith(showFormErrors: showFormError ?? !showFormErrors);
  }

  T reset() {
    return copyWith(
      viewState: ViewState.idle,
      error: const EmptyException(),
      showFormErrors: false,
    );
  }
}
