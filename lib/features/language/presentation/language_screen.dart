import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/core/constant/app_strings.dart';

import '../../../core/constant/app_colors.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});
  /*_languages start here*/
  static final List<Map<String,String>> _languages=[
    {
      'name': AppStrings.english,
      'nativeName': 'English',
      'code': 'en',
      'countryCode': 'US',
    },
    {
      'name': AppStrings.urdu,
      'nativeName': 'اردو',
      'code': 'ur',
      'countryCode': 'PK',
    },
    {
      'name': AppStrings.arabic,
      'nativeName': 'العربية',
      'code': 'ar',
      'countryCode': 'SA',
    },
  ];
  /*_languages end here*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme= theme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final currentCode= context.locale.languageCode;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      /*appBar start here*/
      appBar: AppBar(
        title: Text(AppStrings.changeLanguage.tr(),style: theme.textTheme.titleLarge!.copyWith(
          color: colorScheme.primary,
          fontSize: width * 0.035,
          fontWeight: FontWeight.w600,
        ),
        ),
        centerTitle: true,
        elevation: 0,
        //   backgroundColor: theme.scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ),
        ),
      ),
      /*appBar end here*/
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
/*first portion start here*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.language_rounded,color: AppColors.primary,size: 24,),
                ),
                const SizedBox(width: 14,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.appLanguage.tr(),style: theme.textTheme.titleSmall!.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold,),),
                      const SizedBox(height:4,),
                      Text(AppStrings.selectYourPreferredLanguage.tr(),style: theme.textTheme.titleSmall!.copyWith(color: colorScheme.onSurface,),),
                    ],),
                ),
              ],),
            ),
          ),
/*first portion end here*/
/*second portion start here*/
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 8,
              bottom: 4,
            ),
            child: Text(AppStrings.availableLanguages.tr(),style: theme.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: colorScheme.onSurface,),),
          ),
/*second portion end here*/
          /*third start here*/
          ListView.builder(
            shrinkWrap: true,
            itemCount: _languages.length,
            itemBuilder: (context, index) {
              final lang= _languages[index];
              final isSelected= currentCode==lang["code"];
              return LanguageTile(onTap: () async {
                if(!isSelected){
                  Navigator.pop(context);
                  await context.setLocale(Locale(lang["code"]!),);
                }
              },
                  name: lang["name"]!.tr(), code:lang["code"]!, countryCode: lang["countryCode"]!, nativeName:lang["nativeName"]!, isSelected: isSelected);

            },),
          /*third portion end here*/
          /*last portion start here*/
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(children: [
              Icon(Icons.info_outline_rounded,size: 14,color: colorScheme.onSurfaceVariant,),
              const SizedBox(width: 6,),
              Expanded(child: Text(AppStrings.changingLanguageNote.tr(),style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant,),),),
            ],),
          ),
          /*last portion end here*/
        ],),
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.onTap,
    required this.name,
    required this.code,
    required this.countryCode,
    required this.nativeName,
    required this.isSelected,
  });
  final void Function()? onTap;
  final String name;
  final String nativeName;
  final String code;
  final String countryCode;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme= theme.colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color:isSelected?AppColors.primary.withOpacity(0.08): colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:isSelected? AppColors.primary:colorScheme.surfaceVariant,
              width: isSelected?1.5:1,
            ),
            boxShadow:isSelected? [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]:[
              BoxShadow(
                color: AppColors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(children: [
//Flag
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CountryFlag.fromCountryCode(countryCode,height: 32,width: 46,),),
            //Flag
            const SizedBox(width: 14,),
            //Language name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,),),
                  const SizedBox(height: 2,),
                  Text(nativeName,style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurfaceVariant,),),
                  //Language name
                ],),
            ),
            //SelectedIndicator
            AnimatedContainer(duration:const Duration(milliseconds: 300),
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color:isSelected? AppColors.primary:AppColors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color:isSelected?AppColors.primary: colorScheme.onSurfaceVariant.withOpacity(0.4),
                ),
              ),
              child: isSelected? const Icon(Icons.check_rounded,color: AppColors.white,size: 14,):null,
            ),
            //SelectedIndicator
          ],),
        ),
      ),
    );
  }
}
