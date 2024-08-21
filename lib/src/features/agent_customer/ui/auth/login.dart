import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/features/agent_customer/ui/onboarding/steps/onboarding_steps.dart';
import 'package:prophub/src/theme/app_images.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/widgets/bottons/app_buttons.dart';
import 'package:prophub/src/widgets/text_input/ProphubTextfield.dart';

class Login extends StatefulWidget {

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
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
                          Text('Welcome to PropHub', style: AppTextStyles.h3.copyWith(color: Colors.white)),
                          const SizedBox(
                            height: Constants.guttterXXl,
                          ),
                          PropHubTextField(
                            controller: _email,
                            title: 'Email',
                            color: Colors.transparent,
                            onChanged: (_) => {},
                          ),
                          const SizedBox(
                            height: Constants.gutterLg,
                          ),
                          PropHubTextField(
                            controller: _password,
                            title: 'Password',
                            color: Colors.transparent,
                            onChanged: (_) => {},
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: Constants.gutterLg,
                          ),
                          SizedBox(
                            width: width(context) - 40,
                            child: PropFlatButton(
                              title: 'Login',
                              onTap: () => {},
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
                                "Don't have an Account?",
                                style: AppTextStyles.md.copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              InkWell(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const OnBoardingSteps(), )),
                                child: Text(
                                  'Sign Up',
                                  style: AppTextStyles.md.copyWith(color: Colors.blueGrey),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),),
                  ),
                )
              )
          ),
    ]);
  }
}
