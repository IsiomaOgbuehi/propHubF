import 'package:prophub/src/utilities/enums/agent_type.dart';

import 'validators.dart';
import 'value_failure.dart';
import 'package:either_dart/either.dart';
import 'value_object.dart';

class PhoneNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PhoneNumber(String input) => PhoneNumber._(phoneNumberValidator(input));

  const PhoneNumber._(this.value);
}

class Email extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Email(String value, {bool isRequired = true}) => Email._(emailValidator(value, isRequired));

  const Email._(this.value);
}

class FirstName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory FirstName(String input) => FirstName._(firstNameValidator(input));

  const FirstName._(this.value);
}

class LastName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory LastName(String input) => LastName._(lastNameValidator(input));

  const LastName._(this.value);
}

class MiddleName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory MiddleName(String input) => MiddleName._(middleNameValidator(input));

  const MiddleName._(this.value);
}

class Gender extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Gender(String input) => Gender._(genderValidator(input));

  const Gender._(this.value);
}

/// [Address] ///
class Street extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Street(String input) => Street._(streetValidator(input));

  const Street._(this.value);
}

class AddressState extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory AddressState(String input) => AddressState._(stateValidator(input));

  const AddressState._(this.value);
}

class AddressLga extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory AddressLga(String input) => AddressLga._(lgaValidator(input));

  const AddressLga._(this.value);
}

class AgentRegistrationType extends ValueObject<AgentType> {
  @override
  final Either<ValueFailure<AgentType>, AgentType> value;

  factory AgentRegistrationType(AgentType input) => AgentRegistrationType._(agentValidator(input));

  const AgentRegistrationType._(this.value);
}

class OfficeAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory OfficeAddress(String input) => OfficeAddress._(officeAddressValidator(input));

  const OfficeAddress._(this.value);
}

class CacNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory CacNumber(String input) => CacNumber._(cacNumberValidator(input));

  const CacNumber._(this.value);
}

class ProfessionalCertification extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory ProfessionalCertification(String input) => ProfessionalCertification._(professionalCertValidator(input));

  const ProfessionalCertification._(this.value);
}

/// [Auth] ///

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) => Password._(passwordValidator(input));

  const Password._(this.value);
}

class ConfirmPassword extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory ConfirmPassword({required String confirmPassword, required String password}) =>
      ConfirmPassword._(confirmPasswordValidator(confirmPassword, password));

  const ConfirmPassword._(this.value);
}