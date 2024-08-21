import 'package:equatable/equatable.dart';
import 'package:prophub/src/domain/core/value_failure.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/domain/utilities/option.dart';
import 'package:prophub/src/utilities/enums/agent_type.dart';

class AddressEntity extends Equatable {
  final Street street;
  final AddressState addressState;
  final AddressLga addressLga;
  final AgentRegistrationType agentRegistrationType;
  final CacNumber cacNumber;
  final OfficeAddress? officeAddress;
  final ProfessionalCertification? professionalCertification;

  const AddressEntity(
      {required this.street,
      required this.addressState,
      required this.addressLga,
      required this.agentRegistrationType,
      required this.cacNumber,
      this.officeAddress,
      this.professionalCertification});

  factory AddressEntity.initial() => AddressEntity(
      street: Street(''),
      addressState: AddressState(''),
      addressLga: AddressLga(''),
      agentRegistrationType: AgentRegistrationType(AgentType.legalDraftsman),
      cacNumber: CacNumber(''),
      officeAddress: OfficeAddress(''),
      professionalCertification: ProfessionalCertification(''));

  AddressEntity copyWith({
    Street? street,
    AddressState? addressState,
    AddressLga? addressLga,
    AgentRegistrationType? agentRegistrationType,
    CacNumber? cacNumber,
    OfficeAddress? officeAddress,
    ProfessionalCertification? professionalCertification,
  }) =>
      AddressEntity(
          street: street ?? this.street,
          addressState: addressState ?? this.addressState,
          addressLga: addressLga ?? this.addressLga,
          agentRegistrationType: agentRegistrationType ?? this.agentRegistrationType,
          cacNumber: cacNumber ?? this.cacNumber,
          officeAddress: officeAddress ?? this.officeAddress,
          professionalCertification: professionalCertification ?? this.professionalCertification);

  Option<ValueFailure<dynamic>> get failureOption {
    return street.failureOrNone.fold(
        () => addressState.failureOrNone.fold(
            () => addressLga.failureOrNone.fold(
                () => agentRegistrationType.failureOrNone.fold(
                    () => cacNumber.failureOrNone.fold(
                        () => officeAddress!.failureOrNone.fold(
                            () => professionalCertification!.failureOrNone
                                .fold(() => const None(), (value) => Some(value)),
                            (value) => Some(value)),
                        (value) => Some(value)),
                    (value) => Some(value)),
                (value) => Some(value)),
            (value) => Some(value)),
        (value) => Some(value));
  }

  @override
  List<Object?> get props => [street, addressState, addressLga, agentRegistrationType, cacNumber, officeAddress, professionalCertification];
}
