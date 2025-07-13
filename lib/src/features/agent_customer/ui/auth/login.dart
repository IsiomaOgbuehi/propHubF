import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/domain/core/prophub_view_model.dart';
import 'package:prophub/src/features/agent_customer/ui/onboarding/steps/onboarding_steps.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/bottom_nav.dart';
import 'package:prophub/src/state/auth/state_notifiers/login_state_notifier.dart';
import 'package:prophub/src/theme/app_images.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/utilities/widgets/error_modal.dart';
import 'package:prophub/src/widgets/bottons/app_buttons.dart';
import 'package:prophub/src/widgets/text_input/ProphubTextfield.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    ref.listen(loginProvider.select((value) => value.viewState),
        (prev, next) async {
      isLoading.value = (next == ViewState.loading) ? true : false;
      if (next == ViewState.error) {
        await ErrorModal.errorInfo(
            context, ref.watch(loginProvider).error.message);
      }
      if (next == ViewState.success) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const BottomNav()));
      }
    });
    return Stack(children: [
      Container(
          width: height(context),
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AppImages.onBoardingBg),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
          ))),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: Constants.guttterXXl,
                    ),
                    Text('Welcome to PropHub',
                        style: AppTextStyles.h3.copyWith(color: Colors.white)),
                    const SizedBox(
                      height: Constants.guttterXXl,
                    ),
                    PropHubTextField(
                      controller: _email,
                      title: 'Email',
                      color: Colors.transparent,
                      onChanged:
                          ref.watch(loginProvider.notifier).onChangeEmail,
                    ),
                    const SizedBox(
                      height: Constants.gutterLg,
                    ),
                    PropHubTextField(
                      controller: _password,
                      title: 'Password',
                      color: Colors.transparent,
                      onChanged:
                          ref.watch(loginProvider.notifier).onChangePassword,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: Constants.gutterLg,
                    ),
                    SizedBox(
                      width: width(context) - 40,
                      child: IgnorePointer(
                          ignoring: isLoading.value,
                          child: PropFlatButton(
                            isLoading: isLoading,
                            title: 'Login',
                            onTap:
                                ref.read(loginProvider.notifier).loginBtnOnTap,
                            buttonColor: Colors.blueGrey,
                            textColor: Colors.white,
                            isDisabled: ValueNotifier(ref
                                .watch(loginProvider)
                                .loginForm
                                .failureOption
                                .isSome()),
                          )),
                    ),
                    const SizedBox(
                      height: Constants.gutterMd,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account?",
                          style: AppTextStyles.md.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const OnBoardingSteps(),
                          )),
                          child: Text(
                            'Sign Up',
                            style: AppTextStyles.md
                                .copyWith(color: Colors.blueGrey),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ))),
    ]);
  }
}
