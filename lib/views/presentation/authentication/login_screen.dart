import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/controller/providers/login_provider.dart';
import 'package:neighborgood_assignment/routes/app_routes.dart';
import 'package:neighborgood_assignment/utils/asset/const_asset.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';
import 'package:neighborgood_assignment/utils/helper/shared_prefs_helper.dart';
import 'package:neighborgood_assignment/utils/validation/const_validation.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_button.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_snackbar_helper.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailOrMobileController;
  late TextEditingController _passwordController;


  @override
  void initState() {
    super.initState();
    _emailOrMobileController = TextEditingController();
    _passwordController = TextEditingController();
    checkUserData();
  }

  checkUserData() async {
    List userData = await SharedPrefsHelper.getUserInfo();
    if(userData.isNotEmpty) {
      _emailOrMobileController.text = userData[0];
      _passwordController.text = userData[1];
      Future.delayed(Duration(seconds: 1), () {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _emailOrMobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

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
                      height: 0.08.sh,
                      width: 0.8.sw,
                      child: Image.asset(ConstAsset.appLogo)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.025.sh),
                child: Text(
                  'Welcome Back!',
                  style: ConstFontStyle.textTitle3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.005.sh),
                child: Text(
                  'Let’s login for explore continues',
                  style: ConstFontStyle.hintTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.04.sh),
                child: CustomTextfield(
                  controller: _emailOrMobileController,
                  hintText: 'Email or Phone Number',
                  labelText: 'Email or Phone Number',
                  prefix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ImageIcon(AssetImage(ConstAsset.email), size: 20),
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
                  obSecure: loginProvider.isObscure,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  prefix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ImageIcon(AssetImage(ConstAsset.password), size: 20),
                  ),
                  suffixIcon: IconButton(
                    icon: loginProvider.isObscure
                        ? ImageIcon(AssetImage(ConstAsset.hide), size: 20)
                        : Icon(Icons.visibility_outlined, size: 20),
                    onPressed: () {
                      loginProvider.togglePasswordVisibility();
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
                padding: EdgeInsets.only(top: 0.005.sh),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: ConstFontStyle.primaryTextStyle1!.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: ConstColor.primaryColor,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    value: loginProvider.isChecked,
                    side: BorderSide(width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    onChanged: (bool? value) {
                      loginProvider.toggleRememberMe(value ?? false);
                    },
                    checkColor: ConstColor.white,
                    activeColor: ConstColor.primaryColor,
                  ),
                  Text(
                    'Remember Me',
                    style: ConstFontStyle.textTitle1,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: .03.sh),
                child: CustomButton(
                  title: 'Sign in',
                  onTap: () => loginProvider.login(
                    context,
                    _emailOrMobileController.text,
                    _passwordController.text,
                  ),
                  // loading: loginProvider.isLoading,
                  isButtonEnabled: loginProvider.isButtonEnabled(
                    _emailOrMobileController.text,
                    _passwordController.text,
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
                    Image.asset(
                      ConstAsset.facebook,
                      height: 0.06.sh,
                      width: 0.06.sh,
                    ),
                    SizedBox(width: 0.08.sw),
                    InkWell(
                      onTap: () => loginProvider.signInWithGoogle(context),
                      child: Image.asset(
                        ConstAsset.google,
                        height: 0.06.sh,
                        width: 0.06.sh,
                      ),
                    ),
                    SizedBox(width: 0.08.sw),
                    Image.asset(
                      ConstAsset.apple,
                      height: 0.06.sh,
                      width: 0.06.sh,
                    ),
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
                        text: 'Don’t have an account? ',
                        style: ConstFontStyle.textTitle1,
                      ),
                      TextSpan(
                        text: 'Sign Up here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, ConstRoute.register);
                          },
                        style: ConstFontStyle.primaryTextStyle1!.copyWith(
                          fontWeight: FontWeight.w500,
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
    );
  }
}