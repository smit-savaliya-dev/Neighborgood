
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_button.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  CustomAppbar({this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(ConstAsset.appLogo,height: 0.04.sh,
            width: 0.5.sw,),
        ],
      ),
      // title: Text(title!,style: ConstFontStyle.textTitle1!.copyWith(fontWeight: FontWeight.w600)),
      actions:actions
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0.07.sh);

}

