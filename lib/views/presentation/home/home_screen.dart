import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neighborgood_assignment/controller/providers/post_provider.dart';
import 'package:neighborgood_assignment/models/post_model.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_appbar.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_profile_image.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_text_field.dart';
import 'package:neighborgood_assignment/views/common/widgets/post_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final _dbref = FirebaseDatabase.instance.ref().child('Posts');

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       appBar: CustomAppbar(actions: [
         ImageIcon(AssetImage(ConstAsset.notification), size: 22,color: Colors.black,),
         SizedBox(
           width: 0.03.sw,
         ),
         Image.asset(
           ConstAsset.rank,
           height: 0.032.sh,
           width:0.032.sh,
         ),
         SizedBox(
           width: 0.03.sw,
         ),
       ],),
       body: Padding(
         padding: EdgeInsets.symmetric(horizontal: .025.sw,),
         child: StreamBuilder(
           stream: _dbref.onValue,
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               return Center(child: LoadingAnimationWidget.hexagonDots(
                 color:  ConstColor.black,
                 size: 50,
               ));
             }

             if (snapshot.hasError) {
               return Center(child: Text('Error: ${snapshot.error}'));
             }

             if (!snapshot.hasData) {
               return Center(child: Text('No posts available.'));
             }

             Map? allPosts = snapshot.data!.snapshot.value as Map?;
             print("allPosts : $allPosts");
             // final posts = snapshot.data!;

             List<Post> posts = [];

             if (allPosts != null) {
               posts = allPosts!.entries.map((entry) {
                 final postData = entry.value as Map<dynamic, dynamic>;
                 return Post.fromJson({
                   'id': entry.key,
                   'title': postData['title'],
                   'description': postData['description'],
                   'image': postData['image'],
                 });
               }).toList();
             }

             return ListView.builder(
               itemCount: posts.length,
               itemBuilder: (context, index) {
                 final post = posts[index];
                 return PostWidget(
                   profileImage: ConstAsset.profile_image_2,
                   userName: 'Peter Thornton',
                   subtitle: 'Walking | Running | Cycling...',
                   postTitle:  post.title,
                   postDescription: post.description,
                   postImage: post.imageUrl,
                 );
               },
             );
           },
         ),
       ),

     );
  }

}