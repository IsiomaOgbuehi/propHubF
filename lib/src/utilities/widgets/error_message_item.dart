import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prophub/src/theme/app_colors.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/app_icons.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/utilities/utils.dart';

enum MessageType { error, normal, notice, copy, camera, restriction }

class ErrorMessageItem extends StatefulWidget {
  final String? title;
  final String subtitle;
  final bool useMerchantTheme;
  final bool isDismissible;
  final bool isRestriction;
  final VoidCallback? onAction;
  final BuildContext context;
  final MessageType type;

  const ErrorMessageItem({
    Key? key,
    required this.context,
    this.title,
    required this.subtitle,
    required this.useMerchantTheme,
    required this.isDismissible,
    required this.isRestriction,
    this.type = MessageType.notice,
    this.onAction,
  }) : super(key: key);

  @override
  State<ErrorMessageItem> createState() => _ErrorMessageItemState();
}

class _ErrorMessageItemState extends State<ErrorMessageItem> {
  Timer? timer;

  timeout() {
    timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.maybePop(context);
    });
  }

  @override
  void initState() {
    widget.isDismissible == true ? timeout() : null;
    super.initState();
  }

  Widget icon(MessageType type) {
    switch (type) {
      case MessageType.error:
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFFBB0B3).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AppIcons.warningTwo,
            height: 32,
            width: 32,
          ),
        );
      case MessageType.copy:
        return Container(
          height: 32,
          width: 32,
          decoration: const BoxDecoration(
            color: AppColors.secondary06,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AppIcons.copy,
            height: 20,
            width: 20,
          ),
        );
      case MessageType.normal:
      case MessageType.notice:
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryCyan.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.gpp_good_outlined,
            size: 32.w,
          ),
        );
      case MessageType.restriction:
        return Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: AppColors.secondary06,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.gpp_bad_outlined,
            size: 32.w,
          ),
        );
      default:
        return const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.error,
          size: 32,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 5.h),
      child: InkWell(
        onTap: () {
          if (widget.onAction == null) {
            timer?.cancel();
            Navigator.maybePop(widget.context);
          } else {
            timer?.cancel();
            Navigator.maybePop(widget.context);
            widget.onAction!();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).textTheme.displayLarge!.color!.withOpacity(0.1),
                blurRadius: 80.0,
                spreadRadius: 0.0,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon(widget.type),
                SizedBox(width: 15.w),
                Expanded(
                  child: widget.subtitle.isNotBlank
                      ? Text(
                          widget.subtitle,
                          style: AppTextStyles.body2Medium.copyWith(
                            color: AppColors.neutral08,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      if (widget.onAction == null) {
                        timer?.cancel();
                        Navigator.maybePop(widget.context);
                      } else {
                        timer?.cancel();
                        Navigator.maybePop(widget.context);
                        widget.onAction!();
                      }
                    },
                    child: widget.isRestriction == false
                        ? Icon(
                            Icons.clear,
                            color: Colors.black,
                            size: 18.r,
                          )
                        : Icon(
                            Icons.keyboard_arrow_right,
                            color: searchBarBorder,
                            size: 27.r,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
