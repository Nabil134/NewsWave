import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constant/app_colors.dart';

class ToastUtils{
  ToastUtils._();
  /*show start here*/
static void show(BuildContext context,
    String message,
    {
  ToastGravity gravity=ToastGravity.BOTTOM,
  Color backgroundColor=AppColors.black,
      Color textColor=AppColors.white,
  }){
final fToast=FToast()..init(context);
fToast.showToast(
  gravity: gravity,
  toastDuration: const Duration(seconds: 3),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
    decoration: BoxDecoration(
color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(message,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: textColor,
      ),
    ),
  ),);
}
/*show end here*/
}