import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/theme/app_colors.dart';

showPlatformActionSheet({
  required BuildContext context,
  List<Widget>? actions,
  Widget? options,
  String? title,
  String? subtitle,
  double? height,
  Color? backgroundColor,
}) {
  if (Platform.isIOS) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.primaryMerchant01,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.5.sp,
                color: Theme.of(context).textTheme.headlineLarge!.color,
              ),
            ),
            content: SizedBox(
              width: 280.w,
              height: height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: paleSkyGrey,
                    ),
                  ),
                  options ?? Container(),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.primaryMerchant01,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }
}
