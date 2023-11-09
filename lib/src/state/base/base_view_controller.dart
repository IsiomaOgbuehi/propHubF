import 'package:flutter/material.dart';

abstract class BaseViewController {
  BaseViewController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> isDisabled = ValueNotifier(true);

  Future<void> simulateLoading() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
  }

  void dispose() {}
}

@immutable
abstract class BaseViewModel {
  final bool isLoading;
  final bool isDisabled;

  static const invalidString = '_invalid_string';
  static const invalidDouble = -1.0;
  static const invalidInt = -1;

  const BaseViewModel({this.isLoading = false, this.isDisabled = false});
// T copyWith<T extends BaseViewModel>([bool? isLoading]);
}

