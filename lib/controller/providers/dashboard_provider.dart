import 'package:flutter/material.dart';
import 'package:neighborgood_assignment/views/presentation/home/home_screen.dart';
import 'package:neighborgood_assignment/views/presentation/post/create_post_screen.dart';
import 'package:neighborgood_assignment/views/presentation/profile/profile_screen.dart';
import 'package:neighborgood_assignment/views/presentation/search/search_screen.dart';


class DashboardProvider extends ChangeNotifier {

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    CreatePostScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
