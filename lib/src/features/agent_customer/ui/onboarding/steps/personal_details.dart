import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/features/agent_customer/ui/auth/login.dart';
import 'package:prophub/src/state/onboarding/state_notifiers/onboarding_state_notifier.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/widgets/text_input/ProphubTextfield.dart';

import '../../../../../widgets/bottons/app_buttons.dart';
import '../../../../../widgets/text_input/ProphubDropDown.dart';

class PersonalDetails extends ConsumerStatefulWidget {
  const PersonalDetails({super.key});

  @override
  ConsumerState<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends ConsumerState<PersonalDetails> {
  final _firstname = TextEditingController();
  final _middleName = TextEditingController();
  final _lastName = TextEditingController();
  final _gender = DropdownFieldController();
  final _personalDetailsFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstname.dispose();
    _middleName.dispose();
    _lastName.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = ref.read(onBoardingProvider);

    // Update the TextEditingControllers with the stored values
    _firstname.text = provider.personalDetailForm.firstName.isValid ? provider.personalDetailForm.firstName.getOrCrash() : '';
    _middleName.text = provider.personalDetailForm.middleName.isValid ? provider.personalDetailForm.middleName.getOrCrash() : '';
    _lastName.text = provider.personalDetailForm.lastName.isValid ? provider.personalDetailForm.lastName.getOrCrash() : '';
    _gender.text = provider.personalDetailForm.gender.isValid ? provider.personalDetailForm.gender.getOrCrash() : '';
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(onBoardingProvider);
    final providerAction = ref.watch(onBoardingProvider.notifier);
    return SingleChildScrollView(
      child: Form(
          key: _personalDetailsFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign up to PropHub', style: AppTextStyles.h3.copyWith(color: Colors.white)),
              const SizedBox(
                height: Constants.guttterXXl,
              ),
              PropHubTextField(
                controller: _firstname,
                title: 'First Name',
                color: Colors.transparent,
                onChanged: providerAction.firstNameOnChange,
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              PropHubTextField(
                controller: _middleName,
                title: 'Middle Name',
                color: Colors.transparent,
                onChanged: providerAction.middleNameOnChange,
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              PropHubTextField(
                controller: _lastName,
                title: 'Last Name',
                color: Colors.transparent,
                onChanged: providerAction.lastNameOnChange,
                validator: (_) => provider.personalDetailForm.lastName.failureOrNone.fold(() => null, (value) => value.message),
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              FormCustomDropdownField(
                initialValue: _gender.text,
                dropIconColor: Colors.white54,
                backgroundColor: Colors.transparent,
                items: const ['Male', 'Female'],
                // dropdownValue: ValueNotifier(provider.personalDetailForm.gender.getOrCrash()),
                hintText: 'Gender',
                onChanged: providerAction.setGender,
                validator: (_) =>
                    provider.personalDetailForm.gender.failureOrNone.fold(() => null, (value) => value.message),
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              SizedBox(
                width: width(context) - 40,
                child: PropFlatButton(
                  isDisabled: ValueNotifier(provider.personalDetailForm.failureOption.isSome()),
                  title: 'Proceed',
                  onTap: () {
                    if(provider.personalDetailForm.failureOption.isSome()) return;
                    providerAction.nextPage();
                  },
                  buttonColor: Colors.blueGrey,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: Constants.gutterMd,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an Account?',
                    style: AppTextStyles.md.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Login(),)),
                    child: Text(
                      'Login',
                      style: AppTextStyles.md.copyWith(color: Colors.blueGrey),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
