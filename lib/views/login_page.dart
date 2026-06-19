
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../core/theme/theme.dart';
import 'bottom_nav_bar/home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

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
              Gap.h40,

              //Branding
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientPrimary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.electric_bolt,
                        color: AppColors.accent,
                        size: 48,
                      ),
                    ),
                    Gap.h16,
                    Text(
                      "CSPDCL",
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 2,
                      ),
                    ),
                    Gap.h4,
                    Text(
                      "Photo Spot Billing App",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              Gap.h48,

              // Form
              Text("Login", style: AppTextStyles.h1),
              Gap.h24,

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
                  hint: "••••••••",
                  prefixIcon: Icons.lock_outline,

                  suffixIcon: IconButton(
                    onPressed: () {
                      authController.loginProcess();
                    },
                    icon: authController.loginPasswordHide.value
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  obscureText: authController.loginPasswordHide.value,
                );
              }),
              Gap.h8,

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?"),
                ),
              ),

              Gap.h16,

              //Login Button
              Obx(
                () => AppButton(
                  label: "Login",
                  icon: Icons.login,
                  isLoading: authController.isLoading.value,
                  onPressed: () async {
                    await authController.login();

                    if (authController.isLoginSuccess.value) {
                      Get.snackbar(
                        "Welcome!",
                        authController.message.value,
                        backgroundColor: AppColors.successLight,
                        colorText: AppColors.success,
                      );
                      Get.offAll(() => HomePage());
                    } else {
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

              //Signup Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTextStyles.bodySmall,
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => SignupPage()),
                      child: const Text("Signup"),
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
