import 'package:flutter/material.dart';
import 'package:neighborgood_assignment/controller/providers/loading_provider.dart';
import 'package:neighborgood_assignment/services/auth_service.dart';
import 'package:neighborgood_assignment/utils/helper/shared_prefs_helper.dart';
import 'package:neighborgood_assignment/utils/validation/const_validation.dart';
import 'package:neighborgood_assignment/views/common/widgets/custom_snackbar_helper.dart';
import 'package:neighborgood_assignment/routes/app_routes.dart';

import 'package:provider/provider.dart';

class RegisterProvider with ChangeNotifier {
  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isChecked = false;
  bool _isLoading = false;

  bool get isObscure => _isObscure;
  bool get isObscure1 => _isObscure1;
  bool get isChecked => _isChecked;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isObscure1 = !_isObscure1;
    notifyListeners();
  }

  void toggleAgree(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  bool isButtonEnabled(String name, String email, String password, String confirmPassword) {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        ConstValidation.validateEmailOrPhone(email) == null &&
        ConstValidation.validatePassword(password) == null &&
        ConstValidation.validateConfirmPassword(password, confirmPassword) == null &&
        _isChecked;
  }

  Future<void> register(BuildContext context, String name, String email, String password) async {
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
    FocusScope.of(context).unfocus();

    if (!loadingProvider.isLoading) {
      loadingProvider.showLoader(); // Show loader

      try {
        final authService = AuthService();
        final user = await authService.register(name, email, password);
        print("user : $user");

        if (user != null) {
          await SharedPrefsHelper.setLoggedIn(true);
          showCustomSnackBarHelper('Registration successful!', isError: false);
          Navigator.pushNamedAndRemoveUntil(
            context,
            ConstRoute.dashboard,
                (route) => false,
          );
        } else {
          showCustomSnackBarHelper('Failed to Register');
        }

      } catch (error) {
        showCustomSnackBarHelper('Error: $error');
      } finally {
        loadingProvider.hideLoader();
      }
    }
  }
  
}
