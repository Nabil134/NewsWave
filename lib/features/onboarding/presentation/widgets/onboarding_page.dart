import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.des,
  });
  final String image;
  final String title;
  final String des;

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final theme=Theme.of(context);
    final colorScheme=theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image,
          height: height*0.5,
          width: width,
          fit: BoxFit.cover,
        ),
        SizedBox(height: height*0.01,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall!.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height*0.03,),
              Text(
                des,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
