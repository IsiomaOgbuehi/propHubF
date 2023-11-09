import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/bottom_nav.dart';
import 'package:prophub/src/utilities/utils.dart';
import '../../app_models/lga_state_response.dart';
import '../view_models/onboarding_view_model.dart';

final onBoardingProvider = StateNotifierProvider.autoDispose<OnBoardingStateNotifier, OnBoardingViewModel>(
    (ref) => OnBoardingStateNotifier(ref));

class OnBoardingStateNotifier extends StateNotifier<OnBoardingViewModel> {
  OnBoardingStateNotifier(this.ref)
      : super(OnBoardingViewModel(
            firstname: TextEditingController(),
            personDetailsFormKey: GlobalKey<FormState>(),
            addressFormKey: GlobalKey<FormState>(),
            onBoardingPageController: PageController(initialPage: 0),
            authDetailsFormKey: GlobalKey<FormState>(),
            lastname: TextEditingController(),
            middleName: TextEditingController(),
            address: TextEditingController(),
            phone: TextEditingController(),
            email: TextEditingController(),
            password: TextEditingController(),
            confirmPassword: TextEditingController()));

  final StateNotifierProviderRef ref;

  void initialize() async {
    final json = await getStatesAndLocals();
    state = state.copyWith(states: stateCapitalResponseFromJson(json));
  }

  Future<dynamic> getStatesAndLocals() async {
    final statesAndLocals = await rootBundle.loadString('assets/state_capital_lga.json');
    return jsonDecode(statesAndLocals);
  }

  void stateValidatorTap() => state = state.copyWith(stateValidator: null);

  void addressValidatorTap() => state = state.copyWith(addressValidator: null);

  void stateValidation() {
    if (state.selectedState.isBlank) {
      state = state.copyWith(stateValidator: 'State cannot be empty');
      return;
    }
  }

  void setAgentType(String? value) {
    state = state.copyWith(agentType: value);
  }

  void stateSelectedAction(String? value) {
    state = state.copyWith(lga: "");
    if (value != null) {
      state = state.copyWith(isStateSelected: true);
    } else {
      state = state.copyWith(isStateSelected: false);
    }
    state = state.copyWith(selectedState: value!);
  }

  void setLga(String value) {
    state = state.copyWith(lga: value);
  }

  void setGender(String? value) {
    state = state.copyWith(gender: value);
  }

  void nextPage() {
    state = state.copyWith(pageNumber: state.pageNumber == 0 ? state.pageNumber + 2 : state.pageNumber + 1);
    state.onBoardingPageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void previousPage() {
    state = state.copyWith(pageNumber: state.pageNumber - 1);
    state.onBoardingPageController
        .previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void submitAction(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const BottomNav()));
  }
}
