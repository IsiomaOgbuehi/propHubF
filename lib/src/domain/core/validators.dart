import 'package:prophub/src/domain/utilities/utils.dart';
import 'package:prophub/src/domain/utilities/validators.dart';
import 'package:prophub/src/utilities/enums/agent_type.dart';
import 'value_failure.dart';
import 'package:either_dart/either.dart';

String? entryAmountValidation(String value) {
  if (value.isEmpty) {
    return 'Input a valid amount';
  }
  if (double.parse(value.replaceAll(',', '')) < 10) {
    return 'Input an amount greater than 10';
  }
  return null;
}

Either<ValueFailure<String>, String> phoneNumberValidator(String value, {String? fieldTitle}) {
  final regexPhone = RegExp('^([+]{0,1}[0-9]{1,3})[0-9]{9,11}\$');
  String failure = '';

  if (!regexPhone.hasMatch(value)) {
    failure = '${fieldTitle ?? 'Phone number'} is incorrect';
  }

  if (regexPhone.hasMatch(value) && value.toNumberFormat().length != 14) {
    failure = '${fieldTitle ?? 'Phone number'} is incorrect';
  }

  if (value.isEmpty) {
    failure = '${fieldTitle ?? 'Phone number'} cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));

  return Right(value);
}

Either<ValueFailure<String>, String> emailValidator(String value, bool isRequired) {
  String failure = '';

  if (isRequired) {
    failure = EmailValidator.validateEmail(value) ?? '';
  }
  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> firstNameValidator(String value) {
  String failure = '';
  if (value.length < 3) {
    failure = 'First name cannot be less than 3 characters';
  }
  if (value.isEmpty) {
    failure = 'First name cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> lastNameValidator(String value) {
  String failure = '';
  if (value.length < 3) {
    failure = 'Last name cannot be less than 3 characters';
  }
  if (value.isEmpty) {
    failure = 'Last name cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> middleNameValidator(String value) {
  String failure = '';
  if (value.length < 3) {
    failure = 'Last name cannot be less than 3 characters';
  }
  if (value.isEmpty) {
    failure = 'Last name cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> genderValidator(String value) {
  String failure = '';
  if (value.isEmpty) {
    failure = 'Gender cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> streetValidator(String value) {
  String failure = '';
  if (value.length < 3) {
    failure = 'Street cannot be less than 3 characters';
  }
  if (value.isEmpty) {
    failure = 'Street cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> officeAddressValidator(String value) {
  String failure = '';
  if (value.length < 3) {
    failure = 'Address cannot be less than 3 characters';
  }
  if (value.isEmpty) {
    failure = 'Address cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> cacNumberValidator(String value) {
  String failure = '';
  if (value.length < 5) {
    failure = 'Invalid Cac Number';
  }
  if (value.isEmpty) {
    failure = 'Cac Number cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> professionalCertValidator(String value) {
  String failure = '';
  if (value.isEmpty) {
    failure = 'Certification cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> stateValidator(String value) {
  String failure = '';
  if (value.isEmpty) {
    failure = 'State cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> lgaValidator(String value) {
  String failure = '';
  if (value.isEmpty) {
    failure = 'Lga cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<AgentType>, AgentType> agentValidator(AgentType value) {
  String failure = '';
  if (value.jsonString.isEmpty) {
    failure = 'Agent type cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> passwordValidator(String value) {
  String failure = '';

  if (value.length < 3) {
    failure = 'Password cannot be less than 3 characters';
  }
  if (value.isEmpty) {
    failure = 'Password cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> confirmPasswordValidator(String confirmPassword, String password) {
  String failure = '';
  if(!(confirmPassword == password && confirmPassword.length == password.length)) {
    failure = 'Passwords do not match';
  } else {
    failure = PasswordValidator.validatePassword(confirmPassword) ?? '';
  }
  // failure = (confirmPassword == password && confirmPassword.length == password.length)
  //     ? PasswordValidator.validatePassword(confirmPassword) ?? ''
  //     : 'Passwords do not match';

  if (failure.isNotEmpty) return Left(ValueFailure(confirmPassword, failure));
  return Right(confirmPassword);
}

Either<ValueFailure<String>, String> chatMessageValidator(String value) {
  String failure = '';
  if (value.length < 2) {
    failure = 'Chat cannot be less than 3 characters';
  }
  if (value.isEmpty) {
    failure = 'Chat cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}

Either<ValueFailure<String>, String> createGroupMessageValidator(String value) {
  String failure = '';
  if (value.length < 2) {
    failure = 'Group name cannot be less than 3 characters';
  }
  if (value.isEmpty) {
    failure = 'Group name cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));
  return Right(value);
}