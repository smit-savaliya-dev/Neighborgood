
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';

class CustomButton  extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool? loading;
  final bool isButtonEnabled;
  final double height;
  final Color activeColor;
  final TextStyle?  textStyle;

  const CustomButton({super.key, required this.title, required this.onTap, this.loading, this.isButtonEnabled = true,
    this.height = 0.0625, this.textStyle = null, this.activeColor = ConstColor.primaryColor,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: loading == true ? null : isButtonEnabled ==  false  ? null : onTap,
        splashColor: Colors.white,
        child: Container(
          height: height.sh,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color:
            isButtonEnabled ? activeColor :  ConstColor.disableButtonColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: loading == true

                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Loading ',
                      style: textStyle == null ? ConstFontStyle.buttonTextStyle2 : textStyle,
                    ),
                    SizedBox(width: 0.02.sw,),
                      LoadingAnimationWidget.hexagonDots(
                                    color: Colors.white,
                                    size: 22,
                                  ),
                  ],
                )
            // const CircularProgressIndicator(
            //         color: Colors.white,
            //       )
                : Text(
                    title,
                    style: textStyle == null ? ConstFontStyle.buttonTextStyle2 : textStyle,
                  ),
          ),
        ),
      );
  }
}


class BorderButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const BorderButton({super.key, required this.title, required this.onTap, required this.icon,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      child: Container(
        height: 0.05.sh,
        width: 0.4.sw,
        // padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
        decoration: BoxDecoration(
            color: ConstColor.buttonColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color: ConstColor.borderColor
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(icon),
              size: 20,
            ),
            SizedBox(
              width: 0.03.sw,
            ),
            Text(
              title,
              style: ConstFontStyle.textTitle1!.copyWith(fontSize: 13.sp)
            ),
          ],
        ),
      ),
    );
  }
}