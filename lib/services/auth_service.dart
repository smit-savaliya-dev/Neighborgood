import 'package:http/http.dart' as http;
import 'package:neighborgood_assignment/utils/app_constant/app_constants.dart';
import 'dart:convert';
import '../models/user_model.dart';

class AuthService {
  Future<UserData> login(String emailOrMobile, String password) async {
    final url = Uri.parse(AppConstants.userUri);
    final response = await http.get(url);

    // print(email);
    // print(password);
    // print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);
      for (var user in users) {
        if (user['email_or_phoneNumber'].toLowerCase() == emailOrMobile.toLowerCase() && user['password'] == password) {
          return UserData.fromJson(user); // Corrected to use `user` instead of `response.body`
        }
      }
      throw Exception('Invalid email or password');
    } else {
      throw Exception('Failed to connect to server');
    }
  }


  Future<UserData> register(String name, String email, String password) async {
    final url = Uri.parse(AppConstants.userUri);

    final userData = {
      'name': name,
      'email_or_phoneNumber': email,
      'password': password,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    print(response.body);

    if (response.statusCode == 201) {
      return UserData.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('User already exists or invalid data');
    } else {
      throw Exception('Failed to connect to server');
    }
  }

}
