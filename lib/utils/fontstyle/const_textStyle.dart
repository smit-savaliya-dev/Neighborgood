
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../color/const_color.dart';
import '../font/const_fonts.dart';

class ConstFontStyle {

  static final TextStyle textTitle1 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 16.sp,
    color: ConstColor.black,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle textTitle2 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 18.sp,
    color: ConstColor.black,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle textTitle3 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 20.sp,
    color: ConstColor.black,
    fontWeight: FontWeight.w600,
  );


  static final TextStyle primaryTextStyle1 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 14.sp,
    color: ConstColor.primaryColor,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle primaryTextStyle2 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 20.sp,
    color: ConstColor.primaryColor,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle subTextStyle1 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 16.sp,
    color: ConstColor.subTextColor,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle subTextStyle2 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 18.sp,
    color: ConstColor.subTextColor,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
  );


  static final TextStyle hintTextStyle = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 14.sp,
    color: ConstColor.hintTextColor,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle greyTextStyle = TextStyle(
      fontFamily: ConstFont.interRegular,
      fontSize: 14.sp,
      color: ConstColor.greyTextDarkColor,
      overflow: TextOverflow.ellipsis,
  );

  static final TextStyle redTextStyle = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 12.sp,
    color: ConstColor.redTextColor,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
  );



  static final TextStyle lableTextStyle = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontWeight: FontWeight.w400,
    fontSize: 15.sp,
    color: ConstColor.greyTextDarkColor,
  );


  static final TextStyle buttonTextStyle1 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 16.sp,
    color: ConstColor.white,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle buttonTextStyle2 = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 16.sp,
    color: ConstColor.white,
    fontWeight: FontWeight.w600,
  );

  // new
  static final TextStyle headingBold = TextStyle(
    fontFamily: ConstFont.interRegular,
    fontSize: 20.sp,
    color: ConstColor.black,
    fontWeight: FontWeight.w700,
  );
}
