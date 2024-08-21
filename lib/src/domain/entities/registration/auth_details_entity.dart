import 'package:equatable/equatable.dart';
import 'package:prophub/src/domain/core/value_failure.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/domain/utilities/option.dart';

class AuthDetailsEntity extends Equatable {
  final Email email;
  final PhoneNumber phoneNumber;
  final Password password;
  final ConfirmPassword confirmPassword;

  const AuthDetailsEntity({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  factory AuthDetailsEntity.initial() => AuthDetailsEntity(
      email: Email(''),
      phoneNumber: PhoneNumber(''),
      password: Password(''),
      confirmPassword: ConfirmPassword(password: '', confirmPassword: ''));

  AuthDetailsEntity copyWith({
    Email? email,
    PhoneNumber? phoneNumber,
    Password? password,
    ConfirmPassword? confirmPassword,
  }) =>
      AuthDetailsEntity(
          email: email ?? this.email,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          password: password ?? this.password,
          confirmPassword: confirmPassword ?? this.confirmPassword);

  Option<ValueFailure<dynamic>> get failureOption {
    return email.failureOrNone.fold(
        () => phoneNumber.failureOrNone.fold(
            () => password.failureOrNone.fold(
                () => confirmPassword.failureOrNone.fold(() => const None(), (value) => Some(value)),
                (value) => Some(value)),
            (value) => Some(value)),
        (value) => Some(value));
  }

  @override
  List<Object?> get props => [email, phoneNumber, password, confirmPassword];
}
