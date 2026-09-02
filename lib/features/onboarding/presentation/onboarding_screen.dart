import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/constant/app_colors.dart';
import 'package:news_wave/core/constant/app_images.dart';
import 'package:news_wave/core/constant/app_strings.dart';
import 'package:news_wave/features/onboarding/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider= context.watch<OnboardingProvider>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Column(children: [
          /*first portion start here*/
          Expanded(
            child: PageView(
              controller: provider.pageController,
              onPageChanged:  provider.onPageChange,
              children: [
                OnboardingPage(image: AppImages.onboarding1,title: AppStrings.onboardingTitle1.tr(),des: AppStrings.onboardingDescription1.tr(),),
                OnboardingPage(image: AppImages.onboarding2,title: AppStrings.onboardingTitle2.tr(),des: AppStrings.onboardingDescription2.tr(),),
                OnboardingPage(image: AppImages.onboarding3,title: AppStrings.onboardingTitle3.tr(),des: AppStrings.onboardingDescription3.tr(),),
              ],
            ),
          ),
          /*first portion end here*/
          /*last portion start here*/
          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: width*0.05,
              vertical: height*0.02,
            ),
            child: Row(children: [
              Row(children: List.generate(provider.totalPages, (index){
                final isActive=provider.currentPage==index;
                return AnimatedContainer(
                  height: height*0.025,
                  width:isActive?width*0.06: width*0.025,
                  margin: EdgeInsets.only(
                    right: width*0.015,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive?colorScheme.primary:colorScheme.onSurface.withOpacity(0.25),
                  ),
                  duration: const Duration(milliseconds: 250),);
              }),),
             const  Spacer(),
              if(provider.currentPage>0)
                TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
provider.previousPage();
                }, child: Text(AppStrings.back.tr(),style: TextStyle(
                  color: Colors.white70,
                  fontSize: width * 0.04,
                ),),),
              SizedBox(
                height: height * 0.06,
                width: width * 0.18,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: EdgeInsets.zero,
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
provider.nextPage(context);
                }, child: Text(provider.currentPage==provider.totalPages-1?AppStrings.start.tr():AppStrings.next.tr(),style: theme.textTheme.bodyLarge!.copyWith(
                  color: colorScheme.onPrimary,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w600,
                ),),),
              ),
            ],),
          ),
          /*last portion end here*/
        ],),
      ),
    );
  }
}


