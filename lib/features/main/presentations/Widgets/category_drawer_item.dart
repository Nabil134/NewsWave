import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';

class DrawerCategoryItem  extends StatelessWidget {
  const DrawerCategoryItem ({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
    this.iconColor,
    this.titleColor,
    this.isActive=false,
  });


  final String title;
  final  void Function()? onTap;
  final IconData icon;
  final  Color? iconColor;
  final  Color? titleColor;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final  theme = Theme.of(context);
    final  colorScheme = theme.colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color:isActive?AppColors.primary.withOpacity(0.12):AppColors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          //IconContainer
          Container(
            padding:const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:(iconColor?? AppColors.primary).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,size: 20,
              color: iconColor??AppColors.primary,
            ),
          ),
          //IconContainer
          const SizedBox(width: 14,),
          Expanded(
            child: Text(title,style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: titleColor??colorScheme.onSurface,
            ),),
          ),
          if(isActive)
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),

        ],),
      ),
    );
  }
}

