import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample1/views/bottom_nav_bar/consumers_page/consumers_page.dart';
import 'package:sample1/views/bottom_nav_bar/profile_page.dart';
import '../../views/bottom_nav_bar/dashboard_page.dart';
import '../../views/bottom_nav_bar/history_page.dart';

class BottomNavController extends GetxController {
  final List<Widget> pages = [
    const DashboardPage(),
    const ConsumersPage(),
    HistoryPage(),
    const ProfilePage(),
  ];

  RxInt selectedIndex = 0.obs;
  RxString title = "".obs;
  void changeIndex(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      title.value = "Dashboard";
    } else if (index == 1) {
      title.value = "Consumers";
    } else if (index == 2) {
      title.value = "History";
    } else if (index == 3) {
      title.value = "Profile";
    } else {
      title.value = "Dashboard";
    }
  }
}
