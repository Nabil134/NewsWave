import 'package:flutter/material.dart';

class SnackBarUtils{
  SnackBarUtils._();
  /*show start here*/
static void show(BuildContext context,String message,{
  Color backgroundColor=Colors.red,
  Color textColor=Colors.white,
  Duration duration=const Duration(seconds: 3),
  SnackBarBehavior behaviour =SnackBarBehavior.floating,
  }){
ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
  SnackBar(
    backgroundColor: backgroundColor,
    duration: duration,
    behavior: behaviour,
    content: Text(message,style: TextStyle(color: textColor),),),);
}
/*show end here*/
}