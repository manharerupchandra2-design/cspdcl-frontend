// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:sample1/views/bottom_nav_bar/home_page.dart';
// import 'package:sample1/views/login_page.dart';
//
// import '../../controllers/bottom_nav_controller/bottom_nav_controller.dart';
// import '../../controllers/consumer_controller/bill_history_controller.dart';
// import '../../controllers/consumer_controller/consumer_list_controller.dart';
// import '../../controllers/consumer_controller/reading_history_controller.dart';
// import '../../controllers/dashboard_controller/dashboard_controller.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   final box = GetStorage();
//
//   @override
//   void initState() {
//     super.initState();
//
//     Future.delayed(Duration(seconds: 5), () {
//       String? token = box.read("token");
//       if (token != null) {
//         Get.put(BottomNavController());
//         Get.put(DashboardController());
//         Get.put(ConsumerListController());
//         Get.put(ReadingHistoryController());
//         Get.put(BillHistoryController());
//         Get.offAll(() => HomePage());
//
//       } else {
//         Get.offAll(() => LoginPage());
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             height: double.infinity,
//             width: double.infinity,
//
//             child: Image.asset("assets/icons/app_icon.png", fit: BoxFit.cover),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:sample1/views/bottom_nav_bar/home_page.dart';
import 'package:sample1/views/login_page.dart';

import '../../controllers/bottom_nav_controller/bottom_nav_controller.dart';
import '../../controllers/consumer_controller/bill_history_controller.dart';
import '../../controllers/consumer_controller/consumer_list_controller.dart';
import '../../controllers/consumer_controller/reading_history_controller.dart';
import '../../controllers/dashboard_controller/dashboard_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final box = GetStorage();

  late AnimationController controller;

  late Animation<double> scaleAnim;
  late Animation<double> fadeAnim;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    );

    scaleAnim = Tween<double>(
      begin: .55,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    controller.forward();

    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    String? token = box.read("token");

    if (token != null) {
      Get.put(BottomNavController());
      Get.put(DashboardController());
      Get.put(ConsumerListController());
      Get.put(ReadingHistoryController());
      Get.put(BillHistoryController());

      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => LoginPage());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF42A5F5),
                  Color(0xFF1E88E5),
                  Color(0xFF1565C0),
                ],
              ),
            ),
          ),

          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .08),
              ),
            ),
          ),

          Positioned(
            bottom: -140,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .05),
              ),
            ),
          ),

          Center(
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, child) {
                return Opacity(
                  opacity: fadeAnim.value,
                  child: Transform.scale(scale: scaleAnim.value, child: child),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: "appLogo",
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: .25),
                            blurRadius: 50,
                            spreadRadius: 12,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/icons/icon_fg.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 1800),
                    tween: Tween<double>(begin: 40.0, end: 0),
                    curve: Curves.easeOut,
                    builder: (_, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: Opacity(
                          opacity: (40 - value) / 40,
                          child: child,
                        ),
                      );
                    },
                    child: const Text(
                      "Photo Spot Billing",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "CSPDCL Meter Reader",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .85),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5,
                    ),
                  ),

                  const SizedBox(height: 45),

                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
