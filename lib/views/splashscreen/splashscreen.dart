import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sample1/views/bottom_nav_bar/home_page.dart';
import 'package:sample1/views/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      String? token = box.read("token");
      if (token != null) {
        Get.offAll(() => HomePage());
      } else {
        Get.offAll(() => LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,

            child: Image.asset("assets/image.png", fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
