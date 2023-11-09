import 'package:flutter/cupertino.dart';
import 'package:prophub/src/state/base/base_view_controller.dart';

import '../../app_models/lga_state_response.dart';

class OnBoardingViewModel extends BaseViewModel {
  final GlobalKey<FormState> personDetailsFormKey;
  final GlobalKey<FormState> addressFormKey;
  final GlobalKey<FormState> authDetailsFormKey;
  final TextEditingController firstname;
  final TextEditingController middleName;
  final TextEditingController lastname;
  final String? gender;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController address;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final String? selectedState;
  final String? lga;
  final String? agentType;
  final List<LGAsResponse>? states;
  final bool isStateSelected;
  final String? error;
  final PageController onBoardingPageController;
  final int pageNumber;

  final String? stateValidator;
  final String? addressValidator;

  const OnBoardingViewModel({
    super.isLoading,
    required this.personDetailsFormKey,
    required this.addressFormKey,
    required this.authDetailsFormKey,
    required this.firstname,
    required this.middleName,
    required this.lastname,
    this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
    this.selectedState,
    this.lga,
    this.agentType,
    this.states = const [],
    this.isStateSelected = false,
    this.error,
    required this.onBoardingPageController,
    this.pageNumber = 0,
    this.stateValidator,
    this.addressValidator,
  });

  OnBoardingViewModel copyWith({
    bool? isLoading,
    GlobalKey<FormState>? personDetailsFormKey,
    GlobalKey<FormState>? addressFormKey,
    GlobalKey<FormState>? authDetailsFormKey,
    TextEditingController? firstname,
    TextEditingController? middleName,
    TextEditingController? lastname,
    String? gender,
    TextEditingController? phone,
    TextEditingController? email,
    TextEditingController? address,
    TextEditingController? password,
    TextEditingController? confirmPassword,
    String? selectedState,
    String? lga,
    String? agentType,
    List<LGAsResponse>? states,
    bool? isStateSelected,
    String? error = BaseViewModel.invalidString,
    PageController? onBoardingPageController,
    int? pageNumber,
    String? stateValidator,
    String? addressValidator,
  }) =>
      OnBoardingViewModel(
          isLoading: isLoading ?? this.isLoading,
          personDetailsFormKey: personDetailsFormKey ?? this.personDetailsFormKey,
          addressFormKey: addressFormKey ?? this.addressFormKey,
          authDetailsFormKey: authDetailsFormKey ?? this.authDetailsFormKey,
          firstname: firstname ?? this.firstname,
          lastname: lastname ?? this.lastname,
          middleName: middleName ?? this.middleName,
          gender: gender ?? this.gender,
          phone: phone ?? this.phone,
          email: email ?? this.email,
          address: address ?? this.address,
          password: password ?? this.password,
          confirmPassword: confirmPassword ?? this.confirmPassword,
          selectedState: selectedState ?? this.selectedState,
          lga: lga ?? this.lga,
          agentType: agentType ?? this.agentType,
          states: states ?? this.states,
          isStateSelected: isStateSelected ?? this.isStateSelected,
          error: error ?? this.error,
          onBoardingPageController: onBoardingPageController ?? this.onBoardingPageController,
          pageNumber: pageNumber ?? this.pageNumber,
          stateValidator: stateValidator ?? this.stateValidator,
          addressValidator: addressValidator ?? this.addressValidator);
}
