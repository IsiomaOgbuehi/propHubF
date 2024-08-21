import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static TextStyle h1 = TextStyle(
    fontSize: 64.0.asp,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: -0.03,
  );
  static TextStyle h2 = TextStyle(
    fontSize: 48.0.asp,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: -0.03,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 36.0.asp,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: -0.03,
  );

  static TextStyle xs = TextStyle(
    fontSize: 10.0.asp,
    fontWeight: FontWeight.normal
  );

  static TextStyle md = TextStyle(
    fontSize: 14.0.asp,
    fontWeight: FontWeight.w400,
    color: AppColors.neutral07,
    height: 1.286,
    letterSpacing: -0.015,
  );

  static TextStyle lg = TextStyle(
    fontSize: 18.0.asp,
    fontWeight: FontWeight.w600,
    color: AppColors.neutral07,
    height: 1.778,
    letterSpacing: -0.02,
  );

  static TextStyle body1SemiBold = TextStyle(
    fontSize: 15.0.asp,
    fontWeight: FontWeight.w600,
    color: AppColors.neutral07,
    height: 1.4,
    letterSpacing: -0.01,
  );

  static TextStyle body2Regular = TextStyle(
    fontSize: 14.0.asp,
    fontWeight: FontWeight.w400,
    color: AppColors.neutral07,
    height: 1.286,
    letterSpacing: -0.015,
  );

  static TextStyle body2Medium = body2Regular.copyWith(
    fontWeight: FontWeight.w500,
  );
}

extension ScaledText on num {
  double get asp => ScreenUtil().screenHeight < 750 ? (this + 2).sp : sp;
}