import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/features/splash/providers/splash_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_images.dart';
import '../../../core/constant/app_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashProvider>().navigateToOnboarding(context);
    });
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
/*first portion start here*/
            Container(
              height: width * 0.22,
              width: width * 0.22,
              padding: EdgeInsets.all(width * 0.02),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(width * 0.06),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Image.asset(
                AppImages.splash,
                fit: BoxFit.contain,
              ),
            ),
            /*first portion end here*/
            SizedBox(height: height*0.025,),
            /*second portion start here*/
            Text(AppStrings.appName.tr(),style: TextStyle(
              color: AppColors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),),
            /*second portion end here*/
            SizedBox(height: height*0.012,),
            /*third portion start here*/
            Text(AppStrings.tagline.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 17,
                height: 1.5,
                fontWeight: FontWeight.w400,
            ),),
            /*third portion end here*/
            SizedBox(height: height*0.06,),
            /*last portion start here*/
            SizedBox(
              width: width*0.38,
              child: LinearProgressIndicator(
                minHeight: height * 0.005,
                backgroundColor: AppColors.progressBackground,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            /*last portion end here*/
        ],),),
      ),
    );
  }
}
