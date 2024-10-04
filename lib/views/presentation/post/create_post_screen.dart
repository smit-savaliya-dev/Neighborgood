import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/controller/providers/post_provider.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_button.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_snackbar_helper.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget{
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: ImageIcon(AssetImage(ConstAsset.backArrow), size: 22)),
        titleSpacing: 0,
        title: Text(
          'Create Post',
          style: ConstFontStyle.textTitle1!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: .025.sw, vertical: 0.01.sh),
        child: Consumer<PostProvider>(
          builder: (context, postProvider, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await postProvider.pickImage();
                    },
                    child: DottedBorder(
                      color: ConstColor.borderColor,
                      strokeWidth: 1,
                      dashPattern: [6, 3],
                      radius: Radius.circular(12.r),
                      borderType: BorderType.RRect,
                      child: Container(
                        height: 0.23.sh,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: ConstColor.uploadPostContainerColor,
                        ),
                        child: postProvider.pickedImage != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.file(postProvider.pickedImage!, fit: BoxFit.cover),
                        )
                            : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageIcon(AssetImage(ConstAsset.upload), size: 50),
                              SizedBox(height: 0.02.sh),
                              Text(
                                'Upload a  Image here',
                                style: ConstFontStyle.textTitle1!.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: ConstColor.black,
                                ),
                              ),
                              SizedBox(height: 0.008.sh),
                              Text(
                                'JPG or PNG file size no more than 10MB',
                                style: ConstFontStyle.hintTextStyle!.copyWith(fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.02.sh),
                    child: CustomTextfield(
                      controller: _titleController,
                      hintText: 'Post Title',
                      labelText: 'Event Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        postProvider.checkButtonEnabled(_titleController.text, _descriptionController.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.02.sh),
                    child: CustomTextfield(
                      controller: _descriptionController,
                      hintText: 'Write your description...',
                      labelText: 'Description',
                      isMulti: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        postProvider.checkButtonEnabled(_titleController.text, _descriptionController.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: .2.sh),
                    child: CustomButton(
                      title: 'Share',
                      onTap: () async {
                          await postProvider.uploadPost(
                            _titleController.text,
                            _descriptionController.text,
                          );
                      },
                      loading: postProvider.isLoading,
                      isButtonEnabled: postProvider.isButtonEnabled && postProvider.pickedImage != null,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}