import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/bottom_nav.dart';
import 'package:prophub/src/state/onboarding/view_models/view_state/registration_view_state.dart';
import 'package:prophub/src/utilities/enums/agent_type.dart';
import '../../app_models/lga_state_response.dart';

final onBoardingProvider = StateNotifierProvider.autoDispose<OnBoardingStateNotifier, RegisterAgentViewState>(
    (ref) => OnBoardingStateNotifier(ref));

class OnBoardingStateNotifier extends StateNotifier<RegisterAgentViewState> {
  OnBoardingStateNotifier(this.ref) : super(RegisterAgentViewState.initial());

  final StateNotifierProviderRef ref;

  void initialize() async {
    final json = await getStatesAndLocals();
    state = state.copyWith(states: stateCapitalResponseFromJson(json));
  }

  Future<dynamic> getStatesAndLocals() async {
    final statesAndLocals = await rootBundle.loadString('assets/state_capital_lga.json');
    return jsonDecode(statesAndLocals);
  }

  void firstNameOnChange(String input) {
    state = state.copyWith(
      personalDetailForm: state.personalDetailForm.copyWith(firstName: FirstName(input)),
    );
  }

  void lastNameOnChange(String input) {
    state = state.copyWith(
      personalDetailForm: state.personalDetailForm.copyWith(lastName: LastName(input)),
    );
  }

  void middleNameOnChange(String input) {
    state = state.copyWith(
      personalDetailForm: state.personalDetailForm.copyWith(middleName: MiddleName(input)),
    );
  }

  void setGender(String? value) {
    state = state.copyWith(personalDetailForm: state.personalDetailForm.copyWith(gender: Gender(value!)));
  }

  void setStreetAddress(String input) {
    state = state.copyWith(addressForm: state.addressForm.copyWith(street: Street(input)));
  }

  void cacNumberOnchange(String input) {
    state = state.copyWith(addressForm: state.addressForm.copyWith(cacNumber: CacNumber(input)));
  }

  void officeAddressOnchange(String input) {
    state = state.copyWith(addressForm: state.addressForm.copyWith(officeAddress: OfficeAddress(input)));
  }

  void setProfessionalCertification(File input) {
    state = state.copyWith(
        addressForm: state.addressForm.copyWith(professionalCertification: ProfessionalCertification(input.path)));
  }

  void onStateChange(String input) {
    state = state.copyWith(
        addressForm: state.addressForm.copyWith(addressState: AddressState(input), addressLga: AddressLga('')),
        isStateSelected: true);
  }

  void onLgaChange(String input) {
    state = state.copyWith(
      addressForm: state.addressForm.copyWith(addressLga: AddressLga(input)),
    );
  }

  void setAgentType(String input) {
    state = state.copyWith(
        addressForm: state.addressForm.copyWith(agentRegistrationType: AgentRegistrationType(input.agentType)));
  }

  void emailOnChange(String input) {
    state = state.copyWith(
      authDetailsForm: state.authDetailsForm.copyWith(email: Email(input)),
    );
  }

  void phoneOnChange(String input) {
    state = state.copyWith(
      authDetailsForm: state.authDetailsForm.copyWith(phoneNumber: PhoneNumber(input)),
    );
  }

  void passwordOnChange(String input) {
    state = state.copyWith(
      authDetailsForm: state.authDetailsForm.copyWith(password: Password(input)),
    );
  }

  void confirmPasswordOnChange(String input) {
    state = state.copyWith(
      authDetailsForm: state.authDetailsForm.copyWith(
          confirmPassword:
              ConfirmPassword(password: state.authDetailsForm.password.getOrCrash(), confirmPassword: input)),
    );
  }

  bool disableAddressBtn() {
    if (!{AgentType.legalDraftsman.value, AgentType.architect.value, AgentType.surveyor.value}
            .contains(state.addressForm.agentRegistrationType.getOrCrash().value) &&
        (state.addressForm.street.isValid &&
            state.addressForm.addressState.isValid &&
            state.addressForm.addressLga.isValid &&
            state.addressForm.cacNumber.isValid)) {
      return false;
    }
    return state.addressForm.failureOption.isSome();
  }

  void nextPage() {
    state = state.copyWith(pageNumber: state.pageNumber == 0 ? state.pageNumber + 2 : state.pageNumber + 1);
    state.onBoardingPageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void previousPage() {
    state = state.copyWith(pageNumber: state.pageNumber - 1);
    state.onBoardingPageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void submitAction(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const BottomNav()));
  }
}
