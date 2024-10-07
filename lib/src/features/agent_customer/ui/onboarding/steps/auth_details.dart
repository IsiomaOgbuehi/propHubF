import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/bottom_nav.dart';
import 'package:prophub/src/state/onboarding/state_notifiers/onboarding_state_notifier.dart';

import '../../../../../utilities/constants/app_constants.dart';
import '../../../../../widgets/bottons/app_buttons.dart';
import '../../../../../widgets/text_input/ProphubTextfield.dart';

class AuthDetails extends ConsumerStatefulWidget {
  const AuthDetails({super.key});

  @override
  ConsumerState<AuthDetails> createState() => _AuthDetailsState();
}

class _AuthDetailsState extends ConsumerState<AuthDetails> {
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _authDetailsFormKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = ref.watch(onBoardingProvider);

    _email.text = provider.authDetailsForm.email.isValid ? provider.authDetailsForm.email.getOrCrash() : '';
    _phone.text = provider.authDetailsForm.phoneNumber.isValid ? provider.authDetailsForm.phoneNumber.getOrCrash() : '';
    _password.text = provider.authDetailsForm.password.isValid ? provider.authDetailsForm.password.getOrCrash() : '';
    _confirmPassword.text = provider.authDetailsForm.confirmPassword.isValid ? provider.authDetailsForm.confirmPassword.getOrCrash() : '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(onBoardingProvider);
    final providerAction = ref.watch(onBoardingProvider.notifier);

    return SingleChildScrollView(
        child: Form(
      key: _authDetailsFormKey,
      child: Column(
        children: [
          const SizedBox(
            height: Constants.guttterXXl,
          ),
          PropHubTextField(
            controller: _email,
            title: 'Email',
            color: Colors.transparent,
            onChanged: providerAction.emailOnChange,
          ),
          const SizedBox(
            height: Constants.gutterXl,
          ),
          PropHubTextField(
            controller: _phone,
            title: 'Phone',
            color: Colors.transparent,
            keyboardType: TextInputType.number,
            onChanged: providerAction.phoneOnChange,
          ),
          const SizedBox(
            height: Constants.gutterXl,
          ),
          PropHubTextField(
            controller: _password,
            title: 'Password',
            color: Colors.transparent,
            obscureText: true,
            onChanged: providerAction.passwordOnChange,
          ),
          const SizedBox(
            height: Constants.gutterXl,
          ),
          PropHubTextField(
            controller: _confirmPassword,
            title: 'Confirm Password',
            color: Colors.transparent,
            obscureText: true,
            onChanged: providerAction.confirmPasswordOnChange,
          ),
          const SizedBox(
            height: Constants.gutterXl,
          ),
          SizedBox(
            width: width(context) - 40,
            child: PropFlatButton(
              isDisabled: ValueNotifier(provider.authDetailsForm.failureOption.isSome()),
              title: 'Submit',
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const BottomNav())) ,
              buttonColor: Colors.blueGrey,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    ));
  }
}
