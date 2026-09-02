import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/constant/app_colors.dart';
import 'package:news_wave/core/constant/app_strings.dart';
import 'package:news_wave/core/routes/route_names.dart';
import 'package:news_wave/features/profile/presentation/widgets/custom_profile_tile.dart';
import 'package:provider/provider.dart';
import '../../theme/providers/theme_provider.dart';
import 'widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider= context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    final colorScheme= theme.colorScheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
/*profileHeader start here*/
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: Row(children: [
                //Avator
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_rounded,size: 32,color: AppColors.primary,),
                ),
                //Avator
                const SizedBox(width: 16,),
                //Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(AppStrings.guestUser.tr(),style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),),
                    const SizedBox(height: 4,),
                    Text(AppStrings.signInToSyncYourBookmarks.tr(),style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),),
                  ],),
                ),
                //Info
//LoginButton
ElevatedButton(
  style: ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    backgroundColor: AppColors.primary,
    elevation: 0,
    padding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onPressed: () {
}, child: Text(AppStrings.login.tr(),style: TextStyle(
  color: Colors.white,
  fontSize: 12,
  fontWeight: FontWeight.w600,
),),),
//LoginButton
              ],),
            ),
/*profileHeader end here*/
   const SizedBox(height: 10,),
              /*general Setting start here*/
              SectionHeader(title: AppStrings.generalSettings.tr(),),
              /*general Setting end here*/
              /*Support end here*/
              CustomProfileTile( title: AppStrings.contactUs.tr(),icon: Icons.message_outlined),
              CustomProfileTile( title: AppStrings.darkMode.tr(),icon:themeProvider.isDarkMode? Icons.dark_mode_outlined:Icons.light_mode_outlined, trailing: Switch(activeColor: AppColors.primary, value: themeProvider.isDarkMode,
                onChanged:themeProvider.toggleTheme,),),
              CustomProfileTile( title: AppStrings.changeLanguage.tr(),icon: Icons.language, onTap: () => Navigator.pushNamed(context, RouteNames.changeLanguage),),
              const SizedBox(height: 10,),
              /*Support start here*/
              SectionHeader(title: AppStrings.support.tr(),),
              /*Support end here*/
              CustomProfileTile( title: AppStrings.contactUs.tr(),icon: Icons.message_outlined),
              CustomProfileTile( title: AppStrings.rateTheApp.tr(),icon: Icons.star_outline_rounded),
              const SizedBox(height: 8,),
              /*Legal start here*/
              SectionHeader(title: AppStrings.legal.tr(),),
              /*Legal end here*/
              CustomProfileTile( title: AppStrings.privatePolicy.tr(),icon: Icons.policy_outlined),
              CustomProfileTile( title: AppStrings.aboutUs.tr(),icon: Icons.info_outline_rounded),
              const SizedBox(height: 20),
              Center(child: Text(AppStrings.appVersion.tr(),style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant,),),),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

