import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return Text(title.toUpperCase(),style:
    theme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: theme.colorScheme.onSurfaceVariant,
    ),
    );
  }
}