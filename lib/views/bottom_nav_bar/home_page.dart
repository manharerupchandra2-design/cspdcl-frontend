// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../../controllers/bottom_nav_controller/bottom_nav_controller.dart';
// import '../login_page.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final btmNavController = Get.find<BottomNavController>();
//     final box = GetStorage();//for drawer
//
//     return Obx(
//       () => Scaffold(
//         appBar: AppBar(title: Text(btmNavController.title.value)),
//         drawer: Drawer(
//           child: Column(
//             children: [
//               UserAccountsDrawerHeader(
//                 accountName: Text(box.read("name")),
//                 accountEmail: Text(box.read("email")),
//               ),
//               Expanded(
//                 child: ListView(
//                   children: [
//                     ListTile(title: Text("Home"), leading: Icon((Icons.home))),
//                     Divider(height: 1),
//                     ListTile(
//                       title: Text("Profile"),
//                       leading: Icon((Icons.account_box_rounded)),
//                     ),
//                     Divider(height: 1),
//                     ListTile(
//                       title: Text("Settings"),
//                       leading: Icon((Icons.settings)),
//                     ),
//                     Divider(height: 1),
//                   ],
//                 ),
//               ),
//
//               Divider(),
//
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: Text("Logout"),
//                 onTap: () {
//                   box.erase();
//                   Get.offAll(() => LoginPage());
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: IndexedStack(
//           index: btmNavController.selectedIndex.value,
//           children: btmNavController.pages,
//         ),
//
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: btmNavController.selectedIndex.value,
//           type: BottomNavigationBarType.fixed,
//
//           onTap: btmNavController.changeIndex,
//
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard_outlined),
//               activeIcon: Icon(Icons.dashboard),
//               label: "Dashboard",
//             ),
//
//             BottomNavigationBarItem(
//               icon: Icon(Icons.people_outline),
//               activeIcon: Icon(Icons.people),
//               label: "Consumers",
//             ),
//
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               activeIcon: Icon(Icons.person),
//               label: "Profile",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/bottom_nav_controller/bottom_nav_controller.dart';
import '../../controllers/consumer_controller/bill_history_controller.dart';
import '../../controllers/consumer_controller/consumer_list_controller.dart';
import '../../controllers/consumer_controller/reading_history_controller.dart';
import '../../controllers/dashboard_controller/dashboard_controller.dart';
import '../../core/theme/theme.dart';
import '../login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<BottomNavController>();
    final box = GetStorage();

    return Obx(
      () => Scaffold(
        // ── AppBar ─────────────────────────────────────
        appBar: AppBar(
          title: Text(ctrl.title.value),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
          ],
        ),

        // ── Drawer ─────────────────────────────────────
        drawer: Drawer(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 52, 20, 20),
                decoration: const BoxDecoration(
                  gradient: AppColors.gradientPrimary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.accent,
                      child: Text(
                        (box.read("name") ?? "M")[0].toUpperCase(),
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.textOnAccent,
                        ),
                      ),
                    ),
                    Gap.h12,
                    Text(
                      box.read("name") ?? "",
                      style: AppTextStyles.onPrimaryH2,
                    ),
                    Gap.h4,
                    Text(
                      box.read("email") ?? "",
                      style: AppTextStyles.onPrimaryBody,
                    ),
                    Gap.h4,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.2),
                        borderRadius: AppDimens.brFull,
                        border: Border.all(
                          color: AppColors.accent.withOpacity(0.5),
                        ),
                      ),
                      child: Text(
                        "Meter Reader",
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    _drawerItem(
                      icon: Icons.dashboard_outlined,
                      title: "Dashboard",
                      onTap: () {
                        ctrl.changeIndex(0);
                        Get.back();
                      },
                    ),
                    _drawerItem(
                      icon: Icons.people_outline,
                      title: "Consumers",
                      onTap: () {
                        ctrl.changeIndex(1);
                        Get.back();
                      },
                    ),
                    _drawerItem(
                      icon: Icons.history,
                      title: "History",
                      onTap: () {
                        ctrl.changeIndex(2);
                        Get.back();
                      },
                    ),
                    _drawerItem(
                      icon: Icons.person_outline,
                      title: "Profile",
                      onTap: () {
                        ctrl.changeIndex(3);
                        Get.back();
                      },
                    ),
                    const Divider(),
                    _drawerItem(
                      icon: Icons.settings_outlined,
                      title: "Settings",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // Logout
              const Divider(height: 1),
              _drawerItem(
                icon: Icons.logout,
                title: "Logout",
                color: AppColors.error,
                onTap: () {
                  box.erase();

                  Get.delete<DashboardController>(force: true);
                  Get.delete<ReadingHistoryController>(force: true);
                  Get.delete<BillHistoryController>(force: true);
                  Get.delete<ConsumerListController>(force: true);
                  Get.delete<BottomNavController>(force: true);



                  Get.offAll(() => LoginPage());
                },
              ),
              Gap.h8,
            ],
          ),
        ),

        // ── Body ───────────────────────────────────────
        body: IndexedStack(
          index: ctrl.selectedIndex.value,
          children: ctrl.pages,
        ),

        // ── Bottom Nav ─────────────────────────────────
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: ctrl.selectedIndex.value,
          onTap: ctrl.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: "Consumers",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  // ── Drawer Item Widget ──────────────────────────────
  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final c = color ?? AppColors.textPrimary;
    return ListTile(
      leading: Icon(icon, color: c, size: AppDimens.iconMd),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: c,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: AppDimens.br10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      horizontalTitleGap: 8,
    );
  }
}
