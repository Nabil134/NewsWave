import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/constant/app_colors.dart';
import 'package:news_wave/core/routes/route_names.dart';
import 'package:news_wave/features/main/presentations/Widgets/drawer_item.dart';
import 'package:news_wave/features/main/presentations/Widgets/section_header.dart';
import 'package:news_wave/features/main/providers/main_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../theme/providers/theme_provider.dart';
import 'category_drawer_item.dart';
class NewsDrawer extends StatelessWidget {
  const NewsDrawer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final colorScheme= theme.colorScheme;
    final themeProvider= context.watch<ThemeProvider>();
    final mainProvider= context.watch<MainProvider>();
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(children: [
          /*drawer header start here*/
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration:const  BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
  borderRadius: BorderRadius.circular(20),
  child:   Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
  shape: BoxShape.circle,),
    child:const Icon(Icons.close_rounded,color: AppColors.white,size: 18,),
  ),),
              ),
              // Close button
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child:const Icon(Icons.person_rounded,color: AppColors.white,size: 20,),),
              ),
              const SizedBox(height: 10),
              //Guest UserInfo

              Row(children: [
                const SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      AppStrings.guestUser.tr(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      AppStrings.signInToSyncYourBookmarks.tr(),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                  ],),
                ),
                const SizedBox(width: 5,),
                //Login Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
side: const BorderSide(
  color: AppColors.white,
  width: 1,
),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                  ),
                  onPressed: () {
                }, child: Text(AppStrings.login.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),),
                //Login Button
              ],),
              //Guest UserInfo
              const SizedBox(height: 12),
            ],),
          ),
          /*drawer header end here*/
          const SizedBox(height: 8),
          /*menu items end here*/
          Expanded(
            child: ListView(
              padding:const EdgeInsets.symmetric(horizontal: 12),
              children: [
DrawerCategoryItem(
  isActive: mainProvider.currentIndex==0,
    title: AppStrings.home.tr(), icon: Icons.home,
  onTap: () {
    context.read<MainProvider>().changeIndex(0);
    Navigator.pop(context);
  },
),
                DrawerCategoryItem(
                  isActive: mainProvider.currentIndex==1,
                  title: AppStrings.categories.tr(), icon: Icons.category_rounded,
                  onTap: () {
                    context.read<MainProvider>().changeIndex(1);
                    Navigator.pop(context);
                  },
                ),
                DrawerCategoryItem(
                  isActive: mainProvider.currentIndex==2,
                  title: AppStrings.bookmarks.tr(), icon: Icons.bookmarks_rounded,
                  onTap: () {
                    context.read<MainProvider>().changeIndex(2);
                    Navigator.pop(context);
                  },
                ),
                DrawerCategoryItem(
                  isActive: mainProvider.currentIndex==3,
                  title: AppStrings.profile.tr(), icon: Icons.person,
                  onTap: () {
                    context.read<MainProvider>().changeIndex(3);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8,),
                SectionHeader(title: AppStrings.generalSettings.tr(),),
                DrawerItem( title: AppStrings.darkMode.tr(),icon:themeProvider.isDarkMode? Icons.dark_mode_outlined:Icons.light_mode_outlined, trailing: Switch(activeColor: AppColors.primary, value: themeProvider.isDarkMode,
                  onChanged:themeProvider.toggleTheme,),),
                DrawerItem( title: AppStrings.changeLanguage.tr(),icon: Icons.language,onTap: () => Navigator.pushNamed(context, RouteNames.changeLanguage),),
                DrawerItem( title: AppStrings.contactUs.tr(),icon: Icons.message_outlined),
                DrawerItem( title: AppStrings.rateTheApp.tr(),icon: Icons.star_outline_rounded),
                const SizedBox(height: 8,),
                SectionHeader(title: AppStrings.legal.tr(),),
                DrawerItem( title: AppStrings.privatePolicy.tr(),icon: Icons.policy_outlined),
                DrawerItem( title: AppStrings.aboutUs.tr(),icon: Icons.info_outline_rounded),
              ],
            ),
          ),
          /*menu items end here*/
          // App version at bottom
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              AppStrings.appVersion.tr(),
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],),
      ),
    );
  }
}




