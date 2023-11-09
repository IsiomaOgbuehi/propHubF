import 'package:flutter/cupertino.dart';

extension DisableButtonSet on ValueNotifier<bool> {
  void run(Function? func) async {
    value = true;
    try {
      await Future.sync(() => func?.call());
    } finally {
      value = false;
    }
  }
}

extension Blank on String? {
  bool get isBlank {
    this?.trim();
    if (this != null && this!.isNotEmpty) return false;

    return true;
  }

  bool get isNotBlank {
    return !isBlank;
  }

  String? get str {
    this?.trim();
    if (this != null && this!.isNotEmpty) return this;

    return null;
  }
}