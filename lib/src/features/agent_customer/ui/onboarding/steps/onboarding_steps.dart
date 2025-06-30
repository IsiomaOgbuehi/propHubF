import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/domain/core/prophub_view_model.dart';
import 'package:prophub/src/theme/app_images.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import '../../../../../state/onboarding/state_notifiers/onboarding_state_notifier.dart';
import '../../../../../utilities/widgets/error_modal.dart';
import '../../screens/bottom_nav.dart';
import 'personal_details.dart';
import 'address.dart';
import 'auth_details.dart';

class OnBoardingSteps extends ConsumerStatefulWidget {
  const OnBoardingSteps({super.key});

  @override
  ConsumerState<OnBoardingSteps> createState() => _OnBoardingStepsState();
}

class _OnBoardingStepsState extends ConsumerState<OnBoardingSteps> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(onBoardingProvider);
    final providerAction = ref.watch(onBoardingProvider.notifier);

    ref.listen(onBoardingProvider.select((state) => state.viewState), (previous, next) {
      if(next == ViewState.error) {
        ErrorModal.errorInfo(context, provider.error.message);
        return;
      }
      if(next == ViewState.success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const BottomNav()));
      }
    });

    return WillPopScope(
        onWillPop: () async => provider.pageNumber == 0 ? true : false,
        child: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
              image: AssetImage(AppImages.onBoardingBg),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
            ))),
            Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: provider.pageNumber > 1
                      ? InkWell(
                          onTap: () => providerAction.previousPage(),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ))
                      : const SizedBox.shrink(),
                  backgroundColor: Colors.transparent,
                  actions: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPaddingMd),
                        child: provider.pageNumber > 1
                            ? Text(
                                'Step ${provider.pageNumber}/3',
                                style: const TextStyle(color: Colors.white),
                              )
                            : const SizedBox.shrink())
                  ],
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPaddingMd),
                  child: SafeArea(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: ref.read(onBoardingProvider).onBoardingPageController,
                      children: const [PersonalDetails(), Address(), AuthDetails()],
                    ),
                  ),
                ))
          ],
        ));
  }
}
