import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/controller/providers/loading_provider.dart';
import 'package:neighborgood_assignment/controller/providers/register_provider.dart';
import 'package:neighborgood_assignment/routes/app_routes.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';
import 'package:neighborgood_assignment/utils/validation/const_validation.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_button.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  late TextEditingController _nameController;
  late TextEditingController _emailOrMobileController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailOrMobileController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailOrMobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);


    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: .045.sw),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.06.sh),
                  child: Center(
                    child: Container(
                      // color: Colors.amber,
                        height: 0.08.sh,
                        width: 0.8.sw,
                        child: Image.asset(ConstAsset.appLogo,)
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.025.sh),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create Account',
                      style: ConstFontStyle.textTitle3,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 0.03.sh),
                  child: CustomTextfield(
                    controller: _nameController,
                    hintText: 'Full Name',
                    labelText: 'Full Name',
                    prefix : Padding(
                        padding: const EdgeInsets.all(14.0),
                        child:  ImageIcon(AssetImage(ConstAsset.person),color: ConstColor.hintTextColor,size: 16,)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.025.sh),
                  child: CustomTextfield(
                    controller: _emailOrMobileController,
                    hintText: 'Email or Phone Number',
                    labelText: 'Email or Phone Number',
                    prefix : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:  ImageIcon(AssetImage(ConstAsset.email),size: 20,)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      return ConstValidation.validateEmailOrPhone(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.025.sh),
                  child: CustomTextfield(
                    controller: _passwordController,
                    obSecure:  registerProvider.isObscure,
                    hintText: 'Enter your password',
                    labelText: 'Create Password',
                    prefix : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:  ImageIcon(AssetImage(ConstAsset.password),size: 20,)
                    ),
                    suffixIcon: IconButton(
                      icon: registerProvider.isObscure
                          ? ImageIcon(AssetImage(ConstAsset.hide), size: 20)
                          : Icon(Icons.visibility_outlined, size: 20),
                      onPressed: () {
                        registerProvider.togglePasswordVisibility();
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      return ConstValidation.validatePassword(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.025.sh),
                  child: CustomTextfield(
                    controller: _confirmPasswordController,
                    obSecure:  registerProvider.isObscure1,
                    hintText: 'Re-enter your password',
                    labelText: 'Confirm Password',
                    prefix : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:  ImageIcon(AssetImage(ConstAsset.password),size: 20,)
                    ),
                    suffixIcon: IconButton(
                      icon: registerProvider.isObscure
                          ? ImageIcon(AssetImage(ConstAsset.hide), size: 20)
                          : Icon(Icons.visibility_outlined, size: 20),
                      onPressed: () {
                        registerProvider.toggleConfirmPasswordVisibility();
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      return ConstValidation.validateConfirmPassword(_passwordController.text,value);
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 0.005.sh),
                  child: Row(
                    children: [
                      Checkbox(
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        value: registerProvider.isChecked,
                        side: BorderSide(
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r), // Set the desired border radius here
                        ),
                        onChanged: (bool? value) {
                          registerProvider.toggleAgree(value ?? false);
                        },
                        checkColor: ConstColor.white,
                        activeColor: ConstColor.primaryColor,
                        // shape: OutlinedBorder(),
                      ),
                      Text(
                        'I agree to terms & conditions',
                        style: ConstFontStyle.textTitle1,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: .03.sh),
                  child: CustomButton(
                    title: 'Create Account',
                    onTap: () => registerProvider.register(
                      context,
                      _nameController.text,
                      _emailOrMobileController.text,
                      _passwordController.text,
                    ),
                    // loading: registerProvider.isLoading,
                    isButtonEnabled: registerProvider.isButtonEnabled(
                      _nameController.text,
                      _emailOrMobileController.text,
                      _passwordController.text,
                      _confirmPasswordController.text,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: .04.sh),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.2.sw,
                        child: Divider(),
                      ),
                      Text(
                        'You can Connect with',
                        style: ConstFontStyle.hintTextStyle,
                      ),
                      Container(
                        width: 0.2.sw,
                        child: Divider(),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: .02.sh),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ConstAsset.facebook,height: 0.06.sh,width: 0.06.sh,),
                      SizedBox(width: 0.08.sw,),
                      Image.asset(ConstAsset.google,height: 0.06.sh,width: 0.06.sh,),
                      SizedBox(width: 0.08.sw,),
                      Image.asset(ConstAsset.apple,height: 0.06.sh,width: 0.06.sh,),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: .02.sh),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: ConstFontStyle.textTitle1,
                      children: <TextSpan>[
                        TextSpan(
                          text:  'Already have an account? ',
                          style: ConstFontStyle.textTitle1,
                        ),
                        TextSpan(
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, ConstRoute.login,);
                            },
                          style: ConstFontStyle.primaryTextStyle1!.copyWith(    fontWeight: FontWeight.w500,),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

}
