import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_strings.dart';

Widget buildIdleState(ColorScheme colorScheme, ThemeData theme) {
  return Expanded(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded,
            size: 80,
            color: colorScheme.onSurfaceVariant.withOpacity(0.3),
          ),
          const SizedBox(height: 16,),
          Text(AppStrings.noNewsLoaded.tr(),style: theme.textTheme.bodyLarge,),
        ],
      ),
    ),
  );
}