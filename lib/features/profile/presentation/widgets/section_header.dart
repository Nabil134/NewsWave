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
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        bottom: 4,
        top: 4,
      ),
      child: Text(title.toUpperCase(),style:
      theme.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      ),
    );
  }
}