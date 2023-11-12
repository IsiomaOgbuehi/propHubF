import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/theme/app_colors.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/widgets/scaffold/platform_scaffold.dart';
import 'package:prophub/src/widgets/text_input/ProphubTextfield.dart';

import '../../../../../utilities/constants/app_constants.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text('Categories', style: AppTextStyles.lg.copyWith(fontWeight: FontWeight.w500),),
      ),
      body: (context) => Column(
          children: [
            const SizedBox(height: 10,),
            PropHubBackgroundTextField(
              controller: _searchController,
              title: 'Search',
              prefix: const Icon(Icons.search_rounded, color: Colors.black45,),
              background: Colors.grey.withOpacity(0.2),
              hintText: 'Search',
              color: Colors.black,
            ),
            const SizedBox(height: 20,),
            Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16),
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constants.lowerBorderRadius)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                            // height: 115.h,
                            color: Colors.grey,
                          ),),
                          Row(
                            children: [
                              Expanded(child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                                decoration: const BoxDecoration(color: AppColors.primary),
                                child: Text('Apartment', style: AppTextStyles.md.copyWith(fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constants.lowerBorderRadius)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 115.h,
                              color: Colors.grey,
                            ),),
                          Row(
                            children: [
                              Expanded(child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                                decoration: const BoxDecoration(color: AppColors.primary),
                                child: Text('Land', style: AppTextStyles.md.copyWith(fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constants.lowerBorderRadius)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 115.h,
                              color: Colors.grey,
                            ),),
                          Row(
                            children: [
                              Expanded(child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                                decoration: const BoxDecoration(color: AppColors.primary),
                                child: Text('Flats', style: AppTextStyles.md.copyWith(fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constants.lowerBorderRadius)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 115.h,
                              color: Colors.grey,
                            ),),
                          Row(
                            children: [
                              Expanded(child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                                decoration: const BoxDecoration(color: AppColors.primary),
                                child: Text('Building', style: AppTextStyles.md.copyWith(fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center,),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constants.lowerBorderRadius)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 115.h,
                              color: Colors.grey,
                            ),),
                          Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                                decoration: const BoxDecoration(color: AppColors.primary),

                              ))
                        ],
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constants.lowerBorderRadius)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 115.h,
                              color: Colors.grey,
                            ),),
                          Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                                decoration: const BoxDecoration(color: AppColors.primary),

                              ))
                        ],
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Constants.lowerBorderRadius)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 115.h,
                              color: Colors.grey,
                            ),),
                          Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPaddingSm),
                                decoration: const BoxDecoration(color: AppColors.primary),

                              ))
                        ],
                      ),
                    )
                  ],
                )
                )
          ],
        ),
    );
  }
}