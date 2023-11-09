import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/home/widgets/filter_btn.dart';
import 'package:prophub/src/theme/app_colors.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/widgets/scaffold/platform_scaffold.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<String> filters = ['Popular', 'Comfort', 'Near You', 'Under Construction'];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        backgroundColor: Colors.white,
        applyPadding: false,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            'Hello Peter',
            style: AppTextStyles.lg.copyWith(fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: Constants.scaffoldHorizontalPadding),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.all(Radius.circular(Constants.circularRadius))),
                ))
          ],
        ),
        body: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.scaffoldHorizontalPadding,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on_outlined),
                          Text(
                            'Oyigbo, Rivers State',
                            style: AppTextStyles.md.copyWith(color: Colors.grey),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 35.h,
                    margin: EdgeInsets.only(
                      left: Constants.scaffoldHorizontalPadding,
                    ),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(
                                  right: index + 1 == filters.length ? Constants.scaffoldHorizontalPadding : 0),
                              child: FilterButton(
                                label: filters[index],
                                isActive: index == 0,
                              ),
                            ),
                        separatorBuilder: (context, _) => SizedBox(
                              width: 10.w,
                            ),
                        itemCount: filters.length),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(padding: EdgeInsets.only(left: Constants.scaffoldHorizontalPadding),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 170.h,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(Constants.borderRadius), bottomLeft: Radius.circular(Constants.borderRadius))
                    ),
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                          height: 60,
                          decoration: const BoxDecoration(color: AppColors.primary),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Demix Home Apartment', style: AppTextStyles.md.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 2.h,),
                                  Text('2 beds / 2 Baths / 1,200Ft', style: AppTextStyles.xs.copyWith(color: Colors.white,))
                                ],
                              ),
                              Text('N1,200,000.00', style: AppTextStyles.md.copyWith(color: Colors.white, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(padding: EdgeInsets.only(right: Constants.scaffoldHorizontalPadding),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: 170.h,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(Constants.borderRadius), bottomRight: Radius.circular(Constants.borderRadius))
                        ),
                        child: Column(
                          children: [
                            Expanded(child: Container()),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                              height: 60,
                              decoration: const BoxDecoration(color: AppColors.primary),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Demix Home Apartment', style: AppTextStyles.md.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 2.h,),
                                      Text('2 beds / 2 Baths / 1,200Ft', style: AppTextStyles.xs.copyWith(color: Colors.white,))
                                    ],
                                  ),
                                  Text('N1,200,000.00', style: AppTextStyles.md.copyWith(color: Colors.white, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(padding: EdgeInsets.only(left: Constants.scaffoldHorizontalPadding),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: 170.h,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(Constants.borderRadius), bottomLeft: Radius.circular(Constants.borderRadius))
                        ),
                        child: Column(
                          children: [
                            Expanded(child: Container()),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                              height: 60,
                              decoration: const BoxDecoration(color: AppColors.primary),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Demix Home Apartment', style: AppTextStyles.md.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 2.h,),
                                      Text('2 beds / 2 Baths / 1,200Ft', style: AppTextStyles.xs.copyWith(color: Colors.white,))
                                    ],
                                  ),
                                  Text('N1,200,000.00', style: AppTextStyles.md.copyWith(color: Colors.white, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ));
  }
}
