import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/theme/app_colors.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/widgets/list_tile/PropHubListTile.dart';
import 'package:prophub/src/widgets/scaffold/platform_scaffold.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: AppColors.neutral02,
      applyPadding: false,
      body: (context) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0,
              decoration: const BoxDecoration(
                color: AppColors.primary
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.home_rounded, size: 150, color: Colors.grey.withOpacity(0.3),),
                  )
                ],
              )
            ),
            const SizedBox(height: 15.0,),
            Container(
              // color: AppColors.neutral02,
              padding: EdgeInsets.symmetric(horizontal: Constants.scaffoldHorizontalPadding),
              child: Column(
                children: [
                  PropHubListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    trailing: const Icon(Icons.chevron_right_rounded, size: 20,),
                    tileRadius: BorderRadius.circular(12.0),
                    tileColor: Colors.white,
                      leadSpacing: 20.w,
                      title: Text('View Properties', style: AppTextStyles.body1SemiBold.copyWith(),),
                      subtitle: Text('View/Edit Uploaded Properties', style: AppTextStyles.xs.copyWith(color: AppColors.neutral04,),),
                      leading: Container(
                          height: 38.h,
                          width: 38.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // color: color.withOpacity(0.125),
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.edit_note_rounded, size: 40.0,)
                      )
                  ),
                  const SizedBox(height: 15.0,),
                  PropHubListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      trailing: const Icon(Icons.chevron_right_rounded, size: 20,),
                      tileRadius: BorderRadius.circular(12.0),
                      tileColor: Colors.white,
                      leadSpacing: 20.w,
                      title: Text('Upload Properties', style: AppTextStyles.body1SemiBold.copyWith(),),
                      subtitle: Text('Upload New Properties', style: AppTextStyles.xs.copyWith(color: AppColors.neutral04,),),
                      leading: Container(
                          height: 38.h,
                          width: 38.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // color: color.withOpacity(0.125),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.upload, size: 40.0,)
                      )
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}