import 'package:flutter/material.dart';
import 'features/agent_customer/ui/onboarding/steps/onboarding_steps.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OnBoardingSteps())));
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
