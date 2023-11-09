import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(onBoardingProvider);
    final providerActor = ref.watch(onBoardingProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: Constants.guttterXXl,),
          PropHubTextField(
            controller: provider.email,
            title: 'Email',
            color: Colors.transparent,
          ),
          const SizedBox(height: Constants.gutterXl,),
          PropHubTextField(
            controller: provider.phone,
            title: 'Phone',
            color: Colors.transparent,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: Constants.gutterXl,),
          PropHubTextField(
            controller: provider.password,
            title: 'Password',
            color: Colors.transparent,
            obscureText: true,
          ),
          const SizedBox(height: Constants.gutterXl,),
          PropHubTextField(
            controller: provider.confirmPassword,
            title: 'Confirm Password',
            color: Colors.transparent,
            obscureText: true,
          ),
          const SizedBox(height: Constants.gutterXl,),
          SizedBox(
            width: width(context) - 40,
            child: PropFlatButton(
              title: 'Submit',
              onTap: () => providerActor.submitAction(context),
              buttonColor: Colors.blueGrey,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}