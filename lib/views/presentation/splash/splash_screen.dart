import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/controller/providers/login_provider.dart';
import 'package:neighborgood_assignment/routes/app_routes.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      whereToGo();
    });
  }

  whereToGo() async {
    if (await Provider.of<LoginProvider>(context, listen: false).isLoggedIn()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ConstRoute.dashboard,
            (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ConstRoute.login,
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                  height: 0.3.sh,
                  width: 0.8.sw,
                  child: Image.asset(ConstAsset.appLogo,)
              ),
            ),
          ],
        ),
    );
  }
}
