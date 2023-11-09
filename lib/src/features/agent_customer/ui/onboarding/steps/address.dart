import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/state/onboarding/state_notifiers/onboarding_state_notifier.dart';

import '../../../../../utilities/constants/app_constants.dart';
import '../../../../../widgets/bottons/app_buttons.dart';
import '../../../../../widgets/text_input/ProphubDropDown.dart';
import '../../../../../widgets/text_input/ProphubTextfield.dart';

class Address extends ConsumerStatefulWidget {
  const Address({super.key});

  @override
  ConsumerState<Address> createState() => _AddressState();
}

class _AddressState extends ConsumerState<Address> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onBoardingProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(onBoardingProvider);
    final providerAction = ref.watch(onBoardingProvider.notifier);
    return SingleChildScrollView(
      child: Form(
          key: provider.addressFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: Constants.guttterXXl,
              ),
              PropHubTextField(
                controller: provider.address,
                title: 'Street',
                color: Colors.transparent,
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              Builder(builder: (context) {
                if (provider.states != null) {
                  return CustomDropDownButton(
                    dropIconColor: Colors.white54,
                    backGroundColor: Colors.transparent,
                    items: provider.states!.map((e) => e.state.name).toList(),
                    dropdownValue: ValueNotifier(provider.selectedState),
                    hintText: 'State',
                    onChanged: (String? value) {
                      providerAction.stateValidatorTap();
                      providerAction.stateSelectedAction(value);
                    },
                  );
                } else {
                  return CustomDropDownButton(
                    dropIconColor: Colors.white54,
                    backGroundColor: Colors.transparent,
                    items: const [],
                    dropdownValue: ValueNotifier(provider.selectedState),
                    hintText: 'State',
                    onChanged: (String? value) {},
                  );
                }
              }),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              Builder(builder: (context) {
                if (provider.isStateSelected) {
                  return Builder(
                    builder: (context) => CustomDropDownButton(
                      dropIconColor: Colors.white54,
                      backGroundColor: Colors.transparent,
                      items: provider.states!
                          .firstWhere((element) => element.state.name == provider.selectedState)
                          .state
                          .locals,
                      dropdownValue: ValueNotifier(provider.lga),
                      hintText: 'LGA',
                      onChanged: (String? value) {
                        providerAction.addressValidatorTap();
                        providerAction.setLga(value!);
                      },
                    ),
                  );
                } else {
                  return CustomDropDownButton(
                    dropIconColor: Colors.white54,
                    backGroundColor: Colors.transparent,
                    items: const [],
                    dropdownValue: ValueNotifier(provider.lga),
                    hintText: 'LGA',
                    onChanged: (String? value) {
                      providerAction.setLga(value!);
                    },
                  );
                }
              }),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              CustomDropDownButton(
                dropIconColor: Colors.white54,
                backGroundColor: Colors.transparent,
                items: const ['Business', 'Artisan', 'Advertising'],
                dropdownValue: ValueNotifier(provider.agentType),
                hintText: 'Agent Type',
                onChanged: (String? value) {
                  providerAction.setAgentType(value);
                },
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              SizedBox(
                width: width(context) - 40,
                child: PropFlatButton(
                  title: 'Next',
                  onTap: () => providerAction.nextPage(),
                  buttonColor: Colors.blueGrey,
                  textColor: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
