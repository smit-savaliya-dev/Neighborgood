
class ConstValidation{

  static String? validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.length < 6 || value.length > 12) {
      return 'Password must be between 6 and 12 characters';
    }
    return null;
  }

  static String? validateEmailOrPhone(String value) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegex = RegExp(emailPattern);

    String phonePattern = r'^\+\d{6,15}$';
    RegExp phoneRegex = RegExp(phonePattern);

    String numericPattern = r'^\+\d+$';
    RegExp numericRegex = RegExp(numericPattern);

    String digitsOnlyPattern = r'^\d+$';
    RegExp digitsOnlyRegex = RegExp(digitsOnlyPattern);

    // print("numericRegex");
    // print(numericRegex.hasMatch(value));

    if (!numericRegex.hasMatch(value) && digitsOnlyRegex.hasMatch(value)) {
      return 'Phone number must include a country code starting with "+"';
    } else if (emailRegex.hasMatch(value)) {
      return null;
    } else if (phoneRegex.hasMatch(value)) {
      return null;
    } else {
      // Neither valid email nor valid phone number
      return 'Please enter a valid email address or phone number';
    }
  }

}