import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';


void showCustomSnackBarHelper(String message, {bool isError = true, Duration? duration, Widget? content, EdgeInsetsGeometry? margin, Color? backgroundColor, EdgeInsetsGeometry? padding}) {
  ScaffoldMessenger.of(Get.context!).clearSnackBars();
  final double width = MediaQuery.of(Get.context!).size.width;

  ScaffoldMessenger.of(Get.context!)..hideCurrentSnackBar()..showSnackBar(SnackBar(key: UniqueKey(), content: content ??  Text(message, style: ConstFontStyle.buttonTextStyle1,),
    margin: null,
    duration: duration ?? const Duration(milliseconds: 4000),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.down,
    backgroundColor: backgroundColor ?? (isError ? Colors.red : Colors.green),
    padding: padding,
  ),
  );


}
