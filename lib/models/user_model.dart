class UserData {
  final String id;
  final String name;
  final String emailOrMobile;
  final String password;

  UserData({required this.id, required this.name, required this.emailOrMobile,required this.password});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      emailOrMobile: json['email_or_phoneNumber'],
      password: json['password'],
    );
  }
}

class LoginStatus {
  final bool isSuccess;
  final String message;

  LoginStatus({required this.isSuccess, required this.message});
}
