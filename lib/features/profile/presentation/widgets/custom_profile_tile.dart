import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class CustomProfileTile extends StatelessWidget {
   CustomProfileTile({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
    this.iconColor,
    this.titleColor,
    this.trailing,
  });


  final String title;
  final  void Function()? onTap;
  final IconData icon;
  final  Color? iconColor;
  final  Color? titleColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final  theme = Theme.of(context);
    final  colorScheme = theme.colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
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
            //TrailingIcon
            trailing??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color:iconColor??colorScheme.onSurfaceVariant ,
                ),
            //TrailingIcon
          ],),
        ),
      ),
    );
  }
}

