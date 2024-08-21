
import 'package:prophub/src/domain/utilities/utils.dart';

class AkuCardMatcher {
  static const String cardRegex = '[0-9]{16}';

  static String? matchedNumber(String value) {
    final regExp = RegExp(cardRegex);

    if (regExp.hasMatch(value)) return regExp.firstMatch(value)?[0];

    return null;
  }
}

class FieldValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Field cannot be empty!';
    }
    return null;
  }
}

class TextFieldValidator {
  static String? validate({String? value, int? minLength}) {
    if (value!.isEmpty) {
      return 'Field cannot be empty!';
    }

    if (value.length < (minLength ?? 3)) {
      return 'Input cannot be less than ${minLength ?? 3} letters';
    }

    return null;
  }
}

class EmailValidator {
  static const String emailRegex = '[a-zA-Z0-9+._%-+]{1,256}'
      '\\@'
      '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}'
      '('
      '\\.'
      '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}'
      ')+';
  static const String phoneNumberRegex = '^\\+(?:[0-9] ?){6,14}[0-9]\$';

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    }

    // Regex for email validation
    var regExpEmail = RegExp(emailRegex);
    var regexPhone = RegExp(phoneNumberRegex);
    if (regExpEmail.hasMatch(value) || regexPhone.hasMatch(value)) {
      return null;
    }
    return 'Email is incorrect';
  }
}

class PasswordValidator {
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }

    if (value.length < 3) {
      return 'Password must contain at least eight characters';
    }

    return null;
  }

  static bool isAtLeastEightCharacters(String value) {
    if (value.length >= 8) {
      return true;
    }
    return false;
  }
}

class OtpValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'Fields must not be empty';
    }

    if (value.length < 6) {
      return 'Otp cannot be less than 6 digits';
    }

    return null;
  }
}

class PhoneValidator {
  static const String phoneNumberRegex = '^([+]{0,1}[0-9]{1,3})[0-9]{9,11}\$';

  static String? validate(String value, {String? fieldTitle}) {
    if (value.isEmpty) {
      return '${fieldTitle ?? 'Phone number'} cannot be empty';
    }

    var regexPhone = RegExp(phoneNumberRegex);
    if (regexPhone.hasMatch(value)) {
      if (value.toNumberFormat().length != 14) {
        return '${fieldTitle ?? 'Phone number'} is incorrect';
      }
      return null;
    }
    return '${fieldTitle ?? 'Phone number'} is incorrect';
  }

  static bool boolValidate(String value) {
    var regexPhone = RegExp(phoneNumberRegex);
    if (regexPhone.hasMatch(value)) {
      if (value.toNumberFormat().length != 14) {
        return true;
      }
      return false;
    }

    return true;
  }
}

class ExpDateValidator {
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry Date cannot be empty';
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}
