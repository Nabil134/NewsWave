/*_buildEmptyState start here*/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_strings.dart';

Widget buildEmptyState(ColorScheme colorScheme, ThemeData theme) {
  return Expanded(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.newspaper_outlined,
            size: 80,
            color: colorScheme.onSurfaceVariant.withOpacity(0.3),
          ),
          const SizedBox(height: 16,),
          Text(
            AppStrings.noResultsFound.tr(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],),
    ),
  );
}
/*_buildEmptyState end here*/