import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_strings.dart';
import '../../provider/search_provider.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.provider,
  });

  final SearchProvider provider;


  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    return Row(children: [
      //Back Button
      ValueListenableBuilder(valueListenable: provider.searchController, builder:(context, value, _) {
        return value.text.isEmpty?
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child:const Icon(Icons.arrow_back_ios_new_rounded,size: 18,color: AppColors.primary,) ,),
        ):const SizedBox.shrink();
      },),
      //Back Button
      const SizedBox(width: 15,),
      /*SearchField*/
      Expanded(
        child: TextField(
          textInputAction: TextInputAction.search,
          focusNode: provider.searchFocus,
          controller: provider.searchController,
          onSubmitted: (_) => provider.searchNews(),
          autofocus: true,
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: colorScheme.surface,
            hintText: AppStrings.searchHint,
            hintStyle: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 1.5,
                color: AppColors.primary,
              ),
            ),
            suffixIcon:ValueListenableBuilder(valueListenable: provider.searchController, builder: (context, value, child) {
              return value.text.isNotEmpty? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                icon: Icon(Icons.close_rounded,color: colorScheme.onSurfaceVariant,size: 18,),onPressed: () {
                provider.clearSearch();
              },):
              const   SizedBox.shrink();

            },),
          ),
        ),
      ),
      /*SearchField*/
    ],);
  }
}