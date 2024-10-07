import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/widgets/bottons/app_buttons.dart';

import '../../theme/app_colors.dart';

class ErrorModal {
  static Future<void> errorInfo(BuildContext context, String message,
      [Function? onCloseCallback]) async {
    // emit(state.copyWith(viewState: ViewState.idle));

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (dialogContext) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.neutral00,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Constants.borderRadius,
                ),
                topRight: Radius.circular(Constants.borderRadius)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 27),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 42.h,
                  width: 42.w,
                  decoration: const BoxDecoration(
                    color: AppColors.neutral00,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Iconsax.shield_security, size: 40.w, color: AppColors.primaryOrange)),
              SizedBox(height: 18.h),
              Text(
                'Error!',
                style: AppTextStyles.body2Medium,
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: Text(
                  message,
                  style: AppTextStyles.body2Regular.copyWith(
                    color: AppColors.neutral04,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Flexible(
                    child: AppOutlineButton(
                      onTap: () {
                        Navigator.of(dialogContext).pop(false);
                      },
                      title: 'Cancel',
                      borderColor: AppColors.searchBarHint,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: PropFlatButton(
                      buttonColor: AppColors.primaryDark,
                      onTap: () {
                        Navigator.of(dialogContext).pop(true);
                        onCloseCallback?.call();
                      },
                      title: 'Retry',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}