// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sample1/utils/custom_button.dart';
// import 'package:sample1/views/login_page.dart';
//
// import '../controllers/auth_controller.dart';
// import '../utils/app_spacing.dart';
// import '../utils/custom_textfield.dart';
//
// class SignupPage extends StatelessWidget {
//   SignupPage({super.key});
//
//   final authController = Get.find<AuthController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("SignupPage")),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomTextField(
//               controller: authController.nameController,
//               hintText: "Name",
//               prefixIcon: Icons.person,
//             ),
//             AppSpacing.h20,
//             CustomTextField(
//               controller: authController.mobileController,
//               hintText: "Mobile",
//               prefixIcon: Icons.call,
//             ),
//             AppSpacing.h20,
//             CustomTextField(
//               controller: authController.emailController,
//               hintText: "Email",
//               prefixIcon: Icons.email,
//             ),
//             AppSpacing.h20,
//             CustomTextField(
//               controller: authController.passwordController,
//               hintText: "Password",
//               prefixIcon: Icons.lock,
//             ),
//             AppSpacing.h20,
//
//             Obx(
//               () => CustomButton(
//                 title: "Signup",
//                 onPressed: () async {
//                   await authController.signup();
//                   if (authController.isSignupSuccess.value == true) {
//                     Get.offAll(() => LoginPage());
//                   }
//                 },
//                 isLoading: authController.isLoading.value,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../core/theme/theme.dart'; // ✅ ek import
import 'login_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimens.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Back Button ──────────────────────────
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios_new),
                padding: EdgeInsets.zero,
              ),

              Gap.h16,

              // ── Heading ──────────────────────────────
              Text("Create Account", style: AppTextStyles.displayMedium),
              Gap.h4,
              Text(
                "CSPDCL Meter Reader registration",
                style: AppTextStyles.bodySmall,
              ),

              Gap.h32,

              // ── Fields ───────────────────────────────
              AppTextField(
                controller: authController.nameController,
                label: "Full Name",
                prefixIcon: Icons.person_outline,
              ),

              Gap.h16,

              AppTextField(
                controller: authController.mobileController,
                label: "Mobile Number",
                hint: "10 digit mobile no.",
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),

              Gap.h16,

              AppTextField(
                controller: authController.emailController,
                label: "Email",
                hint: "email@cspdcl.co.in",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              Gap.h16,

              Obx(() {
                return AppTextField(
                  controller: authController.passwordController,
                  label: "Password",
                  hint: "Min. 6 characters",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    onPressed: () {
                      authController.signupProcess();
                    },
                    icon: authController.signupPasswordHide.value
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  obscureText: authController.signupPasswordHide.value,
                );
              }),

              Gap.h16,

              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: AppDimens.br10,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: AppColors.textHint, size: 20),
                        Gap.w8,
                        Text("Select Zone", style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint)),
                      ],
                    ),
                    value: authController.selectedZone.value.isEmpty
                        ? null
                        : authController.selectedZone.value,
                    items: authController.zones.map((zone) =>
                        DropdownMenuItem(value: zone, child: Text(zone))
                    ).toList(),
                    onChanged: (val) => authController.selectedZone.value = val ?? '',
                  ),
                ),
              )),

              Gap.h32,

              //Signup Button
              Obx(
                () => AppButton(
                  label: "Create Account",
                  icon: Icons.person_add_outlined,
                  isLoading: authController.isLoading.value,
                  onPressed: () async {
                    await authController.signup();

                    if (authController.isSignupSuccess.value) {
                      Get.snackbar(
                        "Registered!",
                        "Please Login",
                        backgroundColor: AppColors.successLight,
                        colorText: AppColors.success,
                        duration: Duration(seconds: 2),
                      );
                      await Future.delayed(Duration(seconds: 2));
                      Get.offAll(() => LoginPage());
                    } else if (authController.message.value.isNotEmpty) {
                      Get.snackbar(
                        "Error",
                        authController.message.value,
                        backgroundColor: AppColors.errorLight,
                        colorText: AppColors.error,
                      );
                    }
                  },
                ),
              ),

              Gap.h16,

              //Login Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTextStyles.bodySmall,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),

              Gap.h20,
            ],
          ),
        ),
      ),
    );
  }
}
