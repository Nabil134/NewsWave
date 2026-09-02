import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../constant/app_colors.dart';

class FlushBarUtils{
  FlushBarUtils._();
  /*showError start here*/
static void showError(BuildContext context,String message,{
  Color backgroundColor=Colors.red,
  IconData icon=Icons.error_outline,
  }){
  Flushbar(
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    title: message,
    backgroundColor: backgroundColor,
    icon: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Icon(icon,color: AppColors.white),
    ),
    borderRadius: BorderRadius.circular(12),
    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
  ).show(context);

}
/*showError end here*/
/*showSuccess start here*/
  static void showSuccess(BuildContext context,String message,{
    Color backgroundColor=AppColors.primary,
    IconData icon=Icons.check_circle_outline,
  }){
    Flushbar(
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      title: message,
      backgroundColor: backgroundColor,
      icon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Icon(icon,color: AppColors.white,size: 20,),
      ),
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    ).show(context);

  }
/*showSuccess end here*/
}