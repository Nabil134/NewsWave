import 'package:flutter/material.dart';

import 'loading_container.dart';

class CategoryLoadingCard extends StatelessWidget {
  const CategoryLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    return  Container(
      margin:const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: colorScheme.surface,
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          child: LoadingContainer(
            height: 120,
            width: 120,
          ),
        ),
        const SizedBox(width: 12,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoadingContainer(
                height: 16,
                width: double.infinity,
              ),
              const SizedBox(height: 8,),
              LoadingContainer(
                height: 16,
                width:double.infinity,
              ),
              const SizedBox(height: 10,),
              LoadingContainer(
                height: 12,
                width:80,
              ),
              const SizedBox(height: 6,),
              LoadingContainer(
                height: 10,
                width:100,
              ),
          ],),
        ),
        const SizedBox(width: 10),
      ],),);
  }
}
