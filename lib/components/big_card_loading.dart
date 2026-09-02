import 'package:flutter/material.dart';

import 'loading_container.dart';

class BigCardLoading extends StatelessWidget {
  const BigCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    return Container(
      margin:const  EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(16),
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            child: LoadingContainer(
              height: 200,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
LoadingContainer( height: 16, width:100,),
                const SizedBox(height: 8,),
                LoadingContainer(
                  height: 16,
                  width:double.infinity,
                ),
                const SizedBox(height: 6,),
                LoadingContainer(
                  height: 16,
                  width:double.infinity,
                ),
                const SizedBox(height: 10,),
                LoadingContainer(
                  height: 12,
                  width:80,
                ),
            ],),
          ),
      ],),
    );
  }
}
