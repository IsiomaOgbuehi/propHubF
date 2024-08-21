import 'package:flutter/material.dart';
import 'package:prophub/src/domain/core/prophub_view_model.dart';
import 'package:prophub/src/domain/entities/registration/address_entity.dart';
import 'package:prophub/src/domain/entities/registration/auth_details_entity.dart';
import 'package:prophub/src/domain/entities/registration/personal_detail_entity.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';
import 'package:prophub/src/state/app_models/lga_state_response.dart';

class RegisterAgentViewState extends PropHubViewModel {
  @override
  final PropHubExceptions error;
  @override
  final ViewState viewState;
  final bool showFormErrors;
  final PersonalDetailEntity personalDetailForm;
  final AddressEntity addressForm;
  final AuthDetailsEntity authDetailsForm;
  final List<LGAsResponse>? states;
  final int pageNumber;
  final PageController onBoardingPageController;
  final bool isStateSelected;

  const RegisterAgentViewState({
    required this.error,
    required this.viewState,
    required this.showFormErrors,
    required this.personalDetailForm,
    required this.addressForm,
    required this.authDetailsForm,
    this.states,
    this.pageNumber = 0,
    required this.onBoardingPageController,
    this.isStateSelected = false
  });

  factory RegisterAgentViewState.initial() => RegisterAgentViewState(
      error: const EmptyException(),
      viewState: ViewState.idle,
      showFormErrors: false,
      personalDetailForm: PersonalDetailEntity.initial(),
      addressForm: AddressEntity.initial(),
      authDetailsForm: AuthDetailsEntity.initial(),
      onBoardingPageController: PageController(initialPage: 0));

  RegisterAgentViewState copyWith({
    PropHubExceptions? error,
    ViewState? viewState,
    bool? showFormErrors,
    PersonalDetailEntity? personalDetailForm,
    AddressEntity? addressForm,
    AuthDetailsEntity? authDetailsForm,
    List<LGAsResponse>? states,
    int? pageNumber,
    PageController? onBoardingPageController,
    bool? isStateSelected,
  }) {
    return RegisterAgentViewState(
        error: error ?? this.error,
        viewState: viewState ?? this.viewState,
        showFormErrors: showFormErrors ?? this.showFormErrors,
        personalDetailForm: personalDetailForm ?? this.personalDetailForm,
        addressForm: addressForm ?? this.addressForm,
        authDetailsForm: authDetailsForm ?? this.authDetailsForm,
        states: states ?? this.states,
        pageNumber: pageNumber ?? this.pageNumber,
        onBoardingPageController: onBoardingPageController ?? this.onBoardingPageController,
        isStateSelected: isStateSelected ?? this.isStateSelected);
  }

  @override
  List<Object?> get props =>
      [error, viewState, showFormErrors, personalDetailForm, addressForm, authDetailsForm, states, isStateSelected];
}
