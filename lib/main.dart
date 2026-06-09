import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sample1/controllers/auth_controller.dart';
import 'package:sample1/controllers/consumer_controller/consumer_list_controller.dart';
import 'package:sample1/views/splashscreen/splashscreen.dart';

import 'controllers/bottom_nav_controller/bottom_nav_controller.dart';
import 'controllers/dashboard_controller/dashboard_controller.dart';
import 'package:sample1/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ConsumerListController(), permanent: true);
  Get.put(DashboardController(), permanent: true);
  Get.put(AuthController());
  Get.put(BottomNavController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.light,

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
