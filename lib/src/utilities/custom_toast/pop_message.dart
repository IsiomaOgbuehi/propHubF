import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/utilities/navigation/navigator.dart';
import 'package:prophub/src/utilities/widgets/error_message_item.dart';

extension PopMessage on BuildContext {
  Future<void> showMessage(
      {required bool useMerchantTheme,
        String? title,
        required String subtitle,
        required bool isDismissible,
        required bool isRestriction,
        MessageType type = MessageType.normal,
        VoidCallback? onAction}) async {
    return showModalBottomSheet(
      context: this,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return InkWell(
          onTap: context.pop,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ErrorMessageItem(
                  context: context,
                  title: title,
                  useMerchantTheme: useMerchantTheme,
                  subtitle: subtitle,
                  isDismissible: isDismissible,
                  isRestriction: isRestriction,
                  onAction: onAction,
                  type: type,
                ),
                SizedBox(height: 114.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
