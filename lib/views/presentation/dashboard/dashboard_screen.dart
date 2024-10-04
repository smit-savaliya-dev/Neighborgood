import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/controller/providers/dashboard_provider.dart';
import 'package:neighborgood_assignment/routes/app_routes.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';
import 'package:neighborgood_assignment/utils/helper/shared_prefs_helper.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          return provider.pages[provider.selectedIndex];
        },
      ),
      bottomNavigationBar:  Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          return BottomNavigationBar(
            // elevation: 3,
            useLegacyColorScheme: false,
            backgroundColor: Colors.white,
            selectedItemColor: ConstColor.primaryColor,
            currentIndex: dashboardProvider.selectedIndex,
            unselectedItemColor: ConstColor.black,
            selectedLabelStyle: ConstFontStyle.primaryTextStyle1.copyWith(fontWeight: FontWeight.normal, fontSize: 0),
            unselectedLabelStyle: ConstFontStyle.subTextStyle1.copyWith(
              fontSize: 0,
            ),
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items:  [
              BottomNavigationBarItem(
                label: "",
                icon: ImageIcon(
                  AssetImage(ConstAsset.home,),
                  size: 26,
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: ImageIcon(
                  AssetImage(ConstAsset.search,),
                  size: 26,
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: ImageIcon(
                  AssetImage(ConstAsset.create,),
                  size: 26,
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: ImageIcon(
                  AssetImage(ConstAsset.message,),
                  size: 26,
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                activeIcon: Container(
                  height: 0.035.sh,
                  width:0.035.sh,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ConstColor.primaryColor
                    )
                  ),
                  child: Image.asset(
                    ConstAsset.profile_image_3,
                  ),
                ),
                icon: Image.asset(
                  ConstAsset.profile_image_3,
                  height: 0.035.sh,
                  width:0.035.sh,
                  // fit: BoxFit.cover,
                ),
              ),
            ],
            onTap: (index) => dashboardProvider.changeIndex(index),
          );
        },
      ),
    );
}

}