import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropHubListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final Widget? subtitle;
  final bool dense;
  final EdgeInsets? contentPadding;
  final VoidCallback? onTap;
  final double? leadSpacing;
  final double? verticalSpacing;
  final Color tileColor;
  final BorderRadiusGeometry tileRadius;
  final BoxBorder? tileBorder;

  const PropHubListTile({
    Key? key,
    required this.title,
    this.dense = false,
    this.subtitle,
    this.leading,
    this.trailing,
    this.contentPadding,
    this.onTap,
    this.leadSpacing,
    this.verticalSpacing,
    this.tileColor = Colors.transparent,
    this.tileRadius = BorderRadius.zero,
    this.tileBorder,
  }) : super(key: key);

  EdgeInsets get padding {
    if (dense) {
      return contentPadding ?? EdgeInsets.symmetric(vertical: 10.h);
    } else {
      return contentPadding ?? const EdgeInsets.all(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: dense ? null : 55.h,
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: tileRadius,
          border: tileBorder,
        ),
        padding: padding,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ?? const SizedBox.shrink(),
              SizedBox(width: leadSpacing ?? 13.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    if (subtitle != null)
                      SizedBox(height: verticalSpacing ?? 7.h),
                    if (subtitle != null) subtitle!,
                  ],
                ),
              ),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
