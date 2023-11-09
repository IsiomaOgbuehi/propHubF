import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(onBoardingProvider);
    final providerAction = ref.watch(onBoardingProvider.notifier);
    return SingleChildScrollView(
      child: Form(
        key: provider.personDetailsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome to PropHub', style: AppTextStyles.h3.copyWith(color: Colors.white)),
          const SizedBox(
            height: Constants.guttterXXl,
          ),
          PropHubTextField(
            controller: provider.firstname,
            title: 'First Name',
            color: Colors.transparent,
          ),
          const SizedBox(
            height: Constants.gutterXl,
          ),
          PropHubTextField(
            controller: provider.middleName,
            title: 'Middle Name',
            color: Colors.transparent,
          ),
          const SizedBox(
            height: Constants.gutterXl,
          ),
          PropHubTextField(
            controller: provider.lastname,
            title: 'Last Name',
            color: Colors.transparent,
          ),
          const SizedBox(
            height: Constants.gutterXl,
          ),
          CustomDropDownButton(
            dropIconColor: Colors.white54,
            backGroundColor: Colors.transparent,
            items: const ['Male', 'Female'],
            dropdownValue: ValueNotifier(provider.gender),
            hintText: 'Gender',
            onChanged: (String? value) {
              providerAction.setGender(value);
            },
          ),
          const SizedBox(
            height: Constants.gutterXl,
          ),
          SizedBox(
            width: width(context) - 40,
            child: PropFlatButton(
              title: 'Proceed',
              onTap: () => providerAction.nextPage(),
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
                onTap: () => {},
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
