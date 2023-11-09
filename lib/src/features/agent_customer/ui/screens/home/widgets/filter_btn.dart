import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/theme/app_colors.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';

class FilterButton extends StatelessWidget{
  final String label;
  final bool? isActive;
  const FilterButton({super.key, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(Constants.tileBorderRadius)),
          color: isActive == true ? AppColors.primary : Colors.white,
          border: Border.all(color: isActive == true ? AppColors.primary : Colors.black12)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: AppTextStyles.md.copyWith(
                color: isActive == true ? Colors.white : Colors.black45
            ),)
          ],
        ),
      ),
    );
  }
}