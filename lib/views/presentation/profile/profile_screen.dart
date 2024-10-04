import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/controller/providers/login_provider.dart';
import 'package:neighborgood_assignment/routes/app_routes.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';
import 'package:neighborgood_assignment/utils/helper/shared_prefs_helper.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_appbar.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_button.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_profile_image.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {

  List<String> postImagesList = [
    ConstAsset.post_images_0,
    ConstAsset.post_images_1,
    ConstAsset.post_images_2,
    ConstAsset.post_images_3,
    ConstAsset.post_images_4,
    ConstAsset.post_images_5,
    ConstAsset.post_images_6,
    ConstAsset.post_images_7,
    ConstAsset.post_images_8,
    ConstAsset.post_images_9,
    ConstAsset.post_images_10,
    ConstAsset.post_images_11,
  ];

  List saveImagesList = [
    ConstAsset.post_images_9,
    ConstAsset.post_images_10,
    ConstAsset.post_images_11,
  ];

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
        appBar: CustomAppbar(actions: [
          PopupMenuButton<int>(
            icon: ImageIcon(AssetImage(ConstAsset.menu), size: 26,color: Colors.black,),
            onSelected: (item) async {
              // Provider.of<LoginProvider>(context).signOut();
              await loginProvider.signOut();

              SharedPrefsHelper.setLoggedIn(false);
              Navigator.pushNamedAndRemoveUntil(
                context,
                ConstRoute.login,
                    (Route<dynamic> route) => false,
              );
            },
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  // padding: EdgeInsets.zeo,
                  value: 0, child: Text('Logout',style: ConstFontStyle.textTitle1,)),
            ],
          ),
          SizedBox(
            width: 0.03.sw,
          ),
        ],),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: .025.sw,)!.copyWith(top: 0.01.sh),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.012.sh),
              child: CustomProfileImage(image: ConstAsset.profile_image_3,radius: 40,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.01.sh),
              child: Text('Wilson Saris',style: ConstFontStyle.textTitle1!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.005.sh),
              child: Text(
                'Intrested in Running',
                style: ConstFontStyle.hintTextStyle!.copyWith(fontSize: 12.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.02.sh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: .23.sw,
                    child: Column(
                      children: [
                        Text('15',style: ConstFontStyle.textTitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),),
                        Text(
                          'Post',
                          style: ConstFontStyle.hintTextStyle!.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: .23.sw,
                    child: Column(
                      children: [
                        Text('150',style: ConstFontStyle.textTitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),),
                        Text(
                          'Followers',
                          style: ConstFontStyle.hintTextStyle!.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: .23.sw,
                    child: Column(
                      children: [
                        Text('98',style: ConstFontStyle.textTitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),),
                        Text(
                          'Following',
                          style: ConstFontStyle.hintTextStyle!.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.02.sh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BorderButton(title: 'Edit Profile', onTap: () {}, icon: ConstAsset.edit_profile,),
                  BorderButton(title: 'Create Postcard', onTap: () {}, icon: ConstAsset.create_post,),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.02.sh),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      height: 0.05.sh,
                      width: 0.3.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TabBar(
                        labelColor: ConstColor.primaryColor,
                        unselectedLabelColor: ConstColor.hintTextColor,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: ConstColor.primaryColor,
                            width: 2,
                          ),
                          insets: EdgeInsets.symmetric(horizontal: 40.0),
                        ),

                        tabs: [
                          Tab(
                            icon: ImageIcon(AssetImage(ConstAsset.post_view),size: 22,),
                          ),
                          Tab(
                              child:  ImageIcon(AssetImage(ConstAsset.wishlist),size: 22,)
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: .01.sh),
                      child: Container(
                        height: 0.40.sh,
                        width: double.infinity,
                        child: TabBarView(
                          children: [
                            Container(
                              height: 0.40.sh,
                              width: double.infinity,
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Number of columns
                                  childAspectRatio: 1, // Aspect ratio of each item
                                  crossAxisSpacing: 8.0, // Horizontal spacing between items
                                  mainAxisSpacing: 8.0, // Vertical spacing between items
                                ),
                                itemCount: postImagesList.length,
                                itemBuilder: (context, index) {
                                  String image = postImagesList[index];

                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                      ),
                                      child: Image.asset(
                                        image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 0.40.sh,
                              width: double.infinity,
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Number of columns
                                  childAspectRatio: 1, // Aspect ratio of each item
                                  crossAxisSpacing: 8.0, // Horizontal spacing between items
                                  mainAxisSpacing: 8.0, // Vertical spacing between items
                                ),
                                itemCount: saveImagesList.length,
                                itemBuilder: (context, index) {
                                  String image = saveImagesList[index];

                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                      ),
                                      child: Image.asset(
                                        image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

}