// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final box = GetStorage();
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//
//             const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
//
//             const SizedBox(height: 15),
//
//             Text(
//               box.read("name") ?? "name",
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 5),
//
//             const Text("Meter Reader", style: TextStyle(color: Colors.grey)),
//
//             const SizedBox(height: 25),
//
//             _profileTile(
//               icon: Icons.badge,
//               title: "Employee ID",
//               value: box.read('id').toString(),
//             ),
//
//             const SizedBox(height: 12),
//
//             _profileTile(
//               icon: Icons.phone,
//               title: "Mobile",
//               value: box.read('mobile') ?? "mobile",
//             ),
//
//             const SizedBox(height: 12),
//
//             _profileTile(
//               icon: Icons.email,
//               title: "Email",
//               value: "${box.read('email')}",
//             ),
//
//             const SizedBox(height: 12),
//
//             _profileTile(
//               icon: Icons.location_on,
//               title: "Zone",
//               value: "Kachna",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _profileTile({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//
//       child: Row(
//         children: [
//           Icon(icon),
//
//           const SizedBox(width: 15),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(color: Colors.grey, fontSize: 12),
//                 ),
//
//                 const SizedBox(height: 4),
//
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/theme/theme.dart'; // ✅ ek import

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final name  = box.read("name")   ?? "Meter Reader";
    final email = box.read("email")  ?? "-";
    final mobile = box.read("mobile") ?? "-";
    final id    = box.read("id")?.toString() ?? "-";
    final zone  = box.read("zone")   ?? "-";

    return Scaffold(
      body: SingleChildScrollView(
        padding: AppDimens.pagePadding,
        child: Column(
          children: [
            Gap.h20,

            // ── Avatar + Name ───────────────────────────
            GradientCard(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.accent,
                    child: Text(
                      name[0].toUpperCase(),
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.textOnAccent,
                      ),
                    ),
                  ),
                  Gap.w16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: AppTextStyles.onPrimaryH2),
                        Gap.h4,
                        Text("Meter Reader", style: AppTextStyles.onPrimaryBody),
                        Gap.h8,
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.2),
                            borderRadius: AppDimens.brFull,
                            border: Border.all(
                                color: AppColors.accent.withOpacity(0.5)),
                          ),
                          child: Text(
                            "Active",
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Gap.h20,

            // ── Profile Info ────────────────────────────
            InfoCard(
              title: "Personal Information",
              titleIcon: Icons.person_outline,
              rows: [
                InfoRow("Employee ID", id),
                InfoRow("Mobile",      mobile),
                InfoRow("Email",       email),
                InfoRow("Zone",        zone),
              ],
            ),

            Gap.h12,

            // ── App Info ────────────────────────────────
            InfoCard(
              title: "App Information",
              titleIcon: Icons.info_outline,
              rows: [
                InfoRow("App Version", "1.0.0"),
                InfoRow("Department",  "CSPDCL"),
                InfoRow("Division",    "Raipur"),
              ],
            ),

            Gap.h24,

            // ── Logout Button ───────────────────────────
            AppButton(
              label: "Logout",
              icon: Icons.logout,
              color: AppColors.error,
              onPressed: () {
                box.erase();
                // Get.offAll(() => LoginPage());
              },
            ),

            Gap.h20,
          ],
        ),
      ),
    );
  }
}