import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sample1/models/login_model.dart';
import 'package:sample1/models/signup_model.dart';
import 'package:sample1/services/api_services.dart';

import '../models/meter_reader_model/meter_reader_model.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isLoginSuccess = false.obs;
  RxString message = "".obs;
  RxBool isSignupSuccess = false.obs;
  Rx<MeterReaderModel?> meter_reader = Rx<MeterReaderModel?>(null);

  final box = GetStorage();

  RxBool loginPasswordHide = true.obs;
  RxBool signupPasswordHide = true.obs;

  Future<LoginResponse?> login() async {
    print(
      "email : ${emailController.text},\npassword : ${passwordController.text}",
    );
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      isLoginSuccess.value = false;
      message.value = "All fields are required";
      return LoginResponse(success: false, message: message.value);
    }

    try {
      isLoading.value = true;

      final requester = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      LoginResponse? response = await ApiServices.login(requester);
      meter_reader.value = response?.meterReader ?? null;
      message.value = response?.message ?? "NULL";
      isLoginSuccess.value = response?.success ?? false;

      if (response?.token != null && response?.success == true) {
        box.write("token", response?.token);
        box.write("name", response?.meterReader?.name);
        box.write("email", response?.meterReader?.email);
        box.write('id', response?.meterReader?.id);
        box.write('mobile', response?.meterReader?.mobile);
      }
      print("token:${response?.token.toString()}");
      print(response?.message.toString());
      print("id is : ${response?.meterReader?.id}");
      return response;
    } catch (e) {
      print(e.toString());
      meter_reader.value = null;
      isLoginSuccess.value = false;
      message.value = e.toString().replaceFirst("Exception: ", "");

      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        mobileController.text.isEmpty ||
        passwordController.text.isEmpty) {
      isSignupSuccess.value=false;
      message.value="All fields are required";
      return;
    }

    try {
      isLoading.value = true;
      final requester = SignupRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        mobile: mobileController.text.trim(),
      );
      SignupResponse? response = await ApiServices.signup(requester);
      isSignupSuccess.value = response?.success ?? false;
      message.value = response?.message ?? "Something went wrong";

      print(response.toString());
    } catch (e) {
      isSignupSuccess.value = false;
      message.value = e.toString().replaceFirst("Exception: ", "");
    } finally {
      isLoading.value = false;
    }
  }

  void loginProcess() {
    loginPasswordHide.value = !loginPasswordHide.value;
  }

  void signupProcess() {
    signupPasswordHide.value = !signupPasswordHide.value;
  }
}
