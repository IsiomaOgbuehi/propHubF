import 'package:prophub/src/domain/core/value_failure.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/domain/utilities/option.dart';

class LoginEntity {
  final Email email;
  final Password password;

  const LoginEntity({required this.email, required this.password});

  factory LoginEntity.initial() => LoginEntity(email: Email(''), password: Password(''));

  LoginEntity copyWith({Email? email, Password? password}) =>
      LoginEntity(email: email ?? this.email, password: password ?? this.password);

  Option<ValueFailure<dynamic>> get failureOption {
    return email.failureOrNone
        .fold(() => password.failureOrNone.fold(() => const None(), (value) => Some(value)), (value) => Some(value));
  }

  Map<String, dynamic> toJson() => {'email': email.getOrCrash().replaceAll(' ', ''), 'password': password.getOrCrash()};
}
