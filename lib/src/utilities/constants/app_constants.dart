import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

abstract class Constants {
  static const pageSize = 10;
  static const flatCardElevation = 0.2;

  static const debounceDuration = Duration(milliseconds: 800);

  /// [Radius] ///
  static const double borderRadius = 15;
  static double lowerBorderRadius = 12.r;
  static double circularRadius = 50.r;
  static const double tileBorderRadius = 10;
  static const double progressBorderRadius = 5;

  /// [Padding] ///
  static double horizontalPadding = 12.w;
  static double horizontalPaddingMd = 14.w;
  static double scaffoldHorizontalPadding = 12.w; // 22

  static const double verticalPaddingSm = 8;
  static const double verticalPadding = 24;

  static const int obscureBalanceLength = 5;
  static double iconSize = 24.w;

  /// [Gutters] ///
  static const formVerticalGutter = 11.0;
  static const verticalGutter = 16.0;
  static const horizontalGutter = 16.0;
  static const verticalMargin = 12.0;

  static const gutterXs = 8.0;
  static const gutterSm = 10.0;
  static const gutterMd = 15.0;
  static const gutterLg = 20.0;
  static const gutterXl = 25.0;
  static const guttterXXl = 70.0;


  static const longAnimationDuration = Duration(milliseconds: 1600);
  static const shortAnimationDuration = Duration(milliseconds: 500);
  static const shorterAnimationDuration = Duration(milliseconds: 350);
  // static const roundedBorderShape = RoundedRectangleBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(12)),
  // );

  static double get deviceWidth {
    return ScreenUtil().screenWidth;
  }

  static double get deviceHeight {
    return ScreenUtil().screenHeight;
  }
}

///MediaQuery Width
double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

///MediaQuery Height
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

///Card Height
double cardHeight(BuildContext context) {
  double scale = height(context) < 750
      ? 280.h
      : height(context) < 820
          ? 242.h
          : 232.h;
  return scale;
}

///Card Height
double overlayHeight(BuildContext context) {
  double scale = height(context) < 750
      ? 330.h
      : height(context) < 820
          ? 300.h
          : 290.h;
  return scale;
}

const int defaultPinLength = 4;

///font converter for small phones
double fontConvert(BuildContext context, double font) {
  return height(context) < 750 ? (font + 2).sp : font.sp;
}

String formatTime(DateTime date) {
  return DateFormat.jm().format(date);
}

String formatDate(DateTime dateTime) {
  return DateFormat.yMMMMd('en_US').add_jm().format(dateTime);
}
