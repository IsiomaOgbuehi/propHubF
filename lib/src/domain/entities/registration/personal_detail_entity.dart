import 'package:equatable/equatable.dart';
import 'package:prophub/src/domain/core/value_failure.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/domain/utilities/option.dart';

class PersonalDetailEntity extends Equatable {
  final FirstName firstName;
  final MiddleName middleName;
  final LastName lastName;
  final Gender gender;

  const PersonalDetailEntity({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.gender,
  });

  factory PersonalDetailEntity.initial() => PersonalDetailEntity(
      firstName: FirstName(''), lastName: LastName(''), middleName: MiddleName(''), gender: Gender(''));

  PersonalDetailEntity copyWith({
    FirstName? firstName,
    MiddleName? middleName,
    LastName? lastName,
    Gender? gender,
  }) =>
      PersonalDetailEntity(
          firstName: firstName ?? this.firstName,
          middleName: middleName ?? this.middleName,
          lastName: lastName ?? this.lastName,
          gender: gender ?? this.gender);

  Option<ValueFailure<dynamic>> get failureOption {
    return firstName.failureOrNone.fold(
        () => lastName.failureOrNone.fold(
            () => middleName.failureOrNone.fold(
                () => gender.failureOrNone.fold(() => const None(), (value) => Some(value)), (value) => Some(value)),
            (value) => Some(value)),
        (value) => Some(value));
  }

  @override
  List<Object?> get props => [firstName, middleName, lastName, gender];
}
