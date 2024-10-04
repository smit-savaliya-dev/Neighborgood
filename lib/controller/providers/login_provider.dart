import 'package:flutter/material.dart';
import 'package:neighborgood_assignment/models/user_model.dart';
import 'package:neighborgood_assignment/controller/providers/loading_provider.dart';
import 'package:neighborgood_assignment/services/auth_service.dart';
import 'package:neighborgood_assignment/utils/helper/shared_prefs_helper.dart';
import 'package:neighborgood_assignment/utils/validation/const_validation.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_snackbar_helper.dart';
import 'package:neighborgood_assignment/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider with ChangeNotifier {
  bool _isObscure = true;
  bool _isChecked = false;
  bool _isLoading = false;
  UserData? _user;

  bool get isObscure => _isObscure;
  bool get isChecked => _isChecked;
  bool get isLoading => _isLoading;
  UserData? get user => _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void togglePasswordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  bool isButtonEnabled(String email, String password) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        ConstValidation.validateEmailOrPhone(email) == null &&
        ConstValidation.validatePassword(password) == null;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    FocusScope.of(context).unfocus();

    if (!loadingProvider.isLoading) {
      loadingProvider.showLoader(); // Show loader

      try {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        if (googleAuth == null) {
          showCustomSnackBarHelper('Google sign-in was cancelled', isError: true);
          return; // User cancelled the sign-in process
        }

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          await SharedPrefsHelper.setLoggedIn(true);
          showCustomSnackBarHelper('Logged in successfully!', isError: false);

          Navigator.pushNamedAndRemoveUntil(
            context,
            ConstRoute.dashboard,
                (route) => false,
          );
        } else {
          showCustomSnackBarHelper('Failed to sign in with Google', isError: true);
        }
      } catch (error) {
        showCustomSnackBarHelper('Error: $error', isError: true);
      } finally {
        loadingProvider.hideLoader(); // Hide loader
      }
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }


  Future<void> login(BuildContext context, String emailOrMobile, String password) async {
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    FocusScope.of(context).unfocus();

    if (!loadingProvider.isLoading) {
      loadingProvider.showLoader(); // Show loader

      try {
        _user = await AuthService().login(emailOrMobile, password);
        print("user : $_user");

        if (_user != null) {
          await SharedPrefsHelper.setLoggedIn(true);
          if(_isChecked) {
            await SharedPrefsHelper.setUserInfo(emailOrMobile,password);
          }

          showCustomSnackBarHelper('Logged in successfully!', isError: false);
          Navigator.pushNamedAndRemoveUntil(
            context,
            ConstRoute.dashboard,
                (route) => false,
          );

        } else {
          showCustomSnackBarHelper('Failed to login');
        }
      } catch (error) {
        showCustomSnackBarHelper('Error: $error');
      } finally {
        loadingProvider.hideLoader();
      }
    }
  }

  void logout() async {
    _user = null;
    await SharedPrefsHelper.setLoggedIn(false);
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    return SharedPrefsHelper.getLoggedIn();
  }

}
