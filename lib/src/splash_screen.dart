import 'package:flutter/material.dart';
import 'package:prophub/src/features/agent_customer/ui/auth/login.dart';
import 'package:prophub/src/theme/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 10),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      // child: Center(
      //   child: Image.asset(AppImages.appLogo, width: 80,),
      // ),
    );
  }
}
