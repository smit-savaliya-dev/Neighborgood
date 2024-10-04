
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_profile_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class PostWidget extends StatefulWidget {
  final String profileImage;
  final String userName;
  final String subtitle;
  final String postTitle;
  final String postDescription;
  final String postImage;

  const PostWidget({
    Key? key,
    required this.profileImage,
    required this.userName,
    required this.subtitle,
    required this.postTitle,
    required this.postDescription,
    required this.postImage,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;
  bool _showFullDescription = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendComment() {
    String comment = _controller.text.trim();
    if (comment.isNotEmpty) {
      print("Sending comment: $comment");
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayDescription = widget.postDescription;
    if (!_showFullDescription && widget.postDescription.length > 50) {
      displayDescription = widget.postDescription.substring(0, 50) + '...';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.01.sh),
      margin: EdgeInsets.symmetric(vertical: 0.005.sh),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ConstColor.uploadPostContainerColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomProfileImage(image: widget.profileImage, radius: 18),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: .04.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: ConstFontStyle.textTitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: ConstFontStyle.hintTextStyle!.copyWith(fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ImageIcon(
                  AssetImage(ConstAsset.more_option),
                  size: 26,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.01.sh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.postTitle,
                    style: ConstFontStyle.textTitle1!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Text(
                  displayDescription,
                  style: ConstFontStyle.textTitle1!.copyWith(fontSize: 13.sp),
                ),
                if (widget.postDescription.length > 50)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showFullDescription = !_showFullDescription;
                      });
                    },
                    child: Text(
                      _showFullDescription ? 'See less' : 'See more',
                      style: ConstFontStyle.greyTextStyle.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: ConstColor.greyTextDarkColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            height: 0.23.sh,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 0.01.sh),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: ConstColor.uploadPostContainerColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: widget.postImage,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Shimmer.fromColors(
                      child: Container(color: Colors.grey),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                    ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),

              // Image.asset(
              //   widget.postImage,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 0.25.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _isLiked = !_isLiked;
                        setState(() {

                        });
                      },
                        child: _isLiked ? ImageIcon(AssetImage(ConstAsset.heart),color: Colors.red, size: 22) : ImageIcon(AssetImage(ConstAsset.like), size: 24)),
                    ImageIcon(AssetImage(ConstAsset.comment), size: 24),
                    ImageIcon(AssetImage(ConstAsset.share), size: 22),
                  ],
                ),
              ),
              ImageIcon(AssetImage(ConstAsset.wishlist), size: 24),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top : .01.sh, bottom: .005.sh),
            child: SizedBox(
              height: 0.05.sh,
              child: TextFormField(
                controller: _controller,
                cursorColor: ConstColor.black!.withOpacity(0.5),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  errorMaxLines: 2,
                  hintText: 'Add a comment...',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: ConstFontStyle.hintTextStyle!.copyWith(fontSize: 13.sp),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomProfileImage(image: ConstAsset.profile_image_3, radius: 11.r),
                  ),
                  suffixIcon: IconButton(
                    icon:  Icon(Icons.send, size: 20,),
                    onPressed: _sendComment,
                  ),
                ),
                showCursor: !_isTextEmpty,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


