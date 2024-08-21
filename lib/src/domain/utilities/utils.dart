import 'package:flutter/material.dart';

bool checksEqual(String first, String second) {
  return (first.toLowerCase().trim() == second.toLowerCase().trim());
}

bool checksNotEqual(String first, String second) {
  return (first.toLowerCase().trim() != second.toLowerCase().trim());
}

// extension to allow capitalising the first letter of every charachter
extension StringCasingExtension on String {
  String toCapitalize() => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}

extension StringTitleCaseExtension on String? {
  String? toTitleCase() {
    return this != null
        ? this!.toLowerCase().replaceAllMapped(
        RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'), (Match match) {
      return "${match[0]?[0].toUpperCase()}${match[0]?.substring(1).toLowerCase()}";
    }).replaceAll(RegExp(r'(_|-)+'), ' ')
        : null;
  }
}

extension StringNumberExtension on String {
  static final zeroFirstDigitRegExp = RegExp('^0');
  static final internationalFormatWithPlusFirstDigitsRegExp = RegExp('^[+234]{4}');
  static final internationalFormatWithoutPlusFirstDigitsRegExp = RegExp('^[234]{3}');

  String toNumberFormat() {
    if (isEmpty) {
      return '';
    }

    if (contains(zeroFirstDigitRegExp)) {
      return replaceFirst(zeroFirstDigitRegExp, '+234');
    }

    if (contains(internationalFormatWithPlusFirstDigitsRegExp)) {
      return this;
    }

    if (contains(internationalFormatWithoutPlusFirstDigitsRegExp)) {
      return '+$this';
    }

    return '+234$this';
  }

  String toLocalNumberFormat() {
    if (isEmpty) {
      return '';
    }

    if (contains(internationalFormatWithPlusFirstDigitsRegExp)) {
      return replaceFirst(internationalFormatWithPlusFirstDigitsRegExp, '0');
    }

    if (contains(internationalFormatWithoutPlusFirstDigitsRegExp)) {
      return replaceFirst(internationalFormatWithoutPlusFirstDigitsRegExp, '0');
    }

    return this;
  }

  String get toAmountFormat {
    return isNotEmpty ? replaceAll(',', '') : '';
  }

  double get convertStringToNum {
    return double.tryParse(toAmountFormat) ?? 0;
  }
}

extension ScrollControllerX on ScrollController {
  bool get isAtEndOfList {
    return offset >= (position.maxScrollExtent - 50) && !position.outOfRange;
  }
}

extension ScrollNotificationX on ScrollNotification {
  bool get isAtEndOfList {
    return metrics.pixels >= (metrics.maxScrollExtent - 50) && !metrics.outOfRange;
  }
}

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

extension ListXFunctions<E> on List<E> {
  E? getFirstElementOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }

    return null;
  }
}

// String guiD() {
//   var uuid = const Uuid();
//   return uuid.v4();
// }
