import 'package:flutter/material.dart';
import 'package:neighborgood_assignment/routes/app_routes.dart';
import 'package:neighborgood_assignment/views/presentation/authentication/login_screen.dart';
import 'package:neighborgood_assignment/views/presentation/authentication/register_screen.dart';
import 'package:neighborgood_assignment/views/presentation/dashboard/dashboard_screen.dart';
import 'package:neighborgood_assignment/views/presentation/post/create_post_screen.dart';
import 'package:neighborgood_assignment/views/presentation/splash/splash_screen.dart';


class AppPages {
  static const initialRoute = ConstRoute.splash;
  static Map<String, WidgetBuilder> routes = {
    (ConstRoute.splash): (_) => SplashScreen(),
    (ConstRoute.login): (_) => LoginScreen(),
    (ConstRoute.register): (_) => RegisterScreen(),
    (ConstRoute.dashboard): (_) => DashboardScreen(),
    (ConstRoute.createPostScreen): (_) => CreatePostScreen(),
  };
}