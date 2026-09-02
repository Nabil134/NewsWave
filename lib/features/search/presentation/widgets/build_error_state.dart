/*_buildErrorState start here*/
import 'package:flutter/material.dart';

Widget buildErrorState(ColorScheme colorScheme, ThemeData theme,String message) {
  return Expanded(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_outlined,
            size: 80,
            color: colorScheme.onSurfaceVariant.withOpacity(0.3),
          ),
          const SizedBox(height: 16,),
          Text(message,style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.error,
          ),),
        ],
      ),
    ),
  );
}
/*_buildErrorState end here*/