import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';

class CustomProfileImage extends StatelessWidget{
  final String image;
  final double radius;

  CustomProfileImage({required this.image, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

}