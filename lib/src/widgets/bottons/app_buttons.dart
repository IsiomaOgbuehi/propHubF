// ignore_for_file: Prefer_using_if_null_operators
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/utilities/utils.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class PropFlatButton extends StatelessWidget {
  const PropFlatButton({
    Key? key,
    required this.title,
    this.onTap,
    this.isLoading,
    this.buttonColor,
    this.isSmallButton = false,
    this.customRadius,
    this.borderColor,
    this.loaderColor,
    this.textColor,
    this.isDisabled,
    this.prefixIcon,
    this.suffixIcon,
    this.titleWidget,
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? customRadius;
  final bool isSmallButton;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? loaderColor;
  final Color? textColor;
  final ValueNotifier<bool>? isDisabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueNotifier<bool>? isLoading;

  ValueNotifier<bool> get _isDisabled {
    return isDisabled ?? ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading ?? ValueNotifier<bool>(false),
      builder: (BuildContext context, bool value, Widget? child) {
        return ValueListenableBuilder(
          valueListenable: _isDisabled,
          builder: (context, bool newValue, Widget? child) => AbsorbPointer(
            absorbing: (value || newValue) ? true : false,
            child: Opacity(
              opacity: value ? 0.85 : 1.0,
              child: InkWell(
                onTap: () => isDisabled == null ? _isDisabled.run(onTap) : onTap?.call(),
                child: Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: isSmallButton ? 40.h : 55.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: customRadius ?? BorderRadius.circular(isSmallButton ? 8 : 12),
                    border: Border.all(
                      width: 1.w,
                      color: borderColor ?? Colors.transparent,
                    ),
                    color: buttonColor?.withOpacity(newValue ? 0.5 : 1)
                  ),
                  child: value
                      ? Theme(
                      data: ThemeData(
                        cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark),
                      ),
                      child: SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: CupertinoActivityIndicator(
                          color: loaderColor,
                        ),
                      ))
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prefixIcon != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            prefixIcon!,
                            SizedBox(width: 11.w),
                          ],
                        ),
                      titleWidget ??
                          (value ? const CupertinoActivityIndicator() : Text(
                            title,
                            style: AppTextStyles.md.copyWith(
                              color: textColor ?? Colors.white,
                              fontWeight: isSmallButton ? FontWeight.w700 : FontWeight.w600,
                            ),
                          )),
                      if (suffixIcon != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 11.w),
                            suffixIcon!,
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class AkuDoubleButton extends StatelessWidget {
//   const AkuDoubleButton({
//     Key? key,
//     required this.title,
//     required this.useMerchantTheme,
//     this.onTap,
//     this.buttonColor,
//     required this.isLoading,
//     required this.isDisabled,
//     this.type = UserType.customer,
//     required this.backTap,
//     this.backButtonKey,
//   }) : super(key: key);
//
//   final String title;
//   final VoidCallback? onTap;
//   final Color? buttonColor;
//   final bool useMerchantTheme;
//   final UserType type;
//   final ValueNotifier<bool> isLoading;
//   final ValueNotifier<bool> isDisabled;
//   final VoidCallback? backTap;
//   final Key? backButtonKey;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Flexible(
//           key: backButtonKey,
//           flex: 1,
//           child: InkWell(
//             onTap: backTap,
//             child: Container(
//               height: 55.h,
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: const Icon(
//                 Icons.arrow_back,
//                 color: paleSkyGrey,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 10.w,
//         ),
//         Flexible(
//           key: key,
//           flex: 5,
//           child: ValueListenableBuilder(
//             valueListenable: isLoading,
//             builder: (BuildContext context, bool value, Widget? child) {
//               return ValueListenableBuilder(
//                 valueListenable: isDisabled,
//                 builder: (BuildContext context, bool newValue, Widget? child) {
//                   return AbsorbPointer(
//                     absorbing: (value || newValue) ? true : false,
//                     child: Opacity(
//                       opacity: value ? 0.85 : 1.0,
//                       child: InkWell(
//                         onTap: () => isDisabled.run(onTap),
//                         child: Container(
//                           //margin: const EdgeInsets.symmetric(horizontal: 10),
//                           width: double.infinity,
//                           height: 55.h,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: buttonColor?.withOpacity(newValue ? 0.5 : 1) ??
//                                 (useMerchantTheme == false
//                                     ? Constants.getPrimaryColor(type)
//                                     : AppColors.primaryMerchant01.withOpacity(newValue ? 0.5 : 1)),
//                           ),
//                           child: value
//                               ? Theme(
//                               data: ThemeData(
//                                 cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark),
//                               ),
//                               child: SizedBox(
//                                 height: 20.h,
//                                 width: 20.w,
//                                 child: const CupertinoActivityIndicator(),
//                               ))
//                               : Text(
//                             title,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: -0.1,
//                               fontSize: fontConvert(context, 15),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    Key? key,
    required this.title,
    this.onTap,
    this.buttonState = false,
    this.borderColor = paleSkyGrey,
    this.borderWidth = 1.0,
    this.textColor = Colors.black,
    this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool buttonState;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: buttonState,
      child: InkWell(
          onTap: onTap,
          child: Container(
            height: 55.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: borderColor,
                width: borderWidth,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  SizedBox(width: 8.w),
                ],
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                    fontSize: 14,
                  ),
                ),
                buttonState
                    ? SizedBox(
                  width: 10.h,
                )
                    : const SizedBox(),
                buttonState
                    ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.neutral03),
                    backgroundColor: Colors.white,
                  ),
                )
                    : const SizedBox(
                  height: 0,
                  width: 0,
                )
              ],
            ),
          )),
    );
  }
}
