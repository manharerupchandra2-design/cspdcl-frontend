import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sample1/models/login_model.dart';
import 'package:sample1/models/signup_model.dart';

import '../controllers/auth_controller.dart';
import '../core/theme/app_colors.dart';
import '../models/consumer_detail_model/bil_history_model.dart';
import '../models/consumer_detail_model/bill_model.dart';
import '../models/consumer_detail_model/consumer_detail_response.dart';
import '../models/consumer_detail_model/reading_history_model.dart';
import '../models/consumer_detail_model/set_reading_model.dart';
import '../models/consumer_model/consumer_response.dart';

import 'package:mime/mime.dart';

import '../models/dashboard_model/dashboard_model.dart';
import '../views/login_page.dart';

class ApiServices {
  static const String baseUrl = "https://cspdcl-backend.onrender.com/api";
  static final box = GetStorage();
  static String get token => box.read('token');

  static Future<LoginResponse?> login(LoginRequest requester) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/meter_reader/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(requester.toJson()),
          )
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 401) {
        handleUnauthorized();
        return null;
      }
      final result = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200 && result['success'] == true) {
        return LoginResponse.fromJson(result);
      }
      throw Exception(result['message']);
    } on SocketException {
      throw Exception("No Internet");
    } on TimeoutException {
      throw Exception("Server timeout");
    }
  }

  static Future<SignupResponse?> signup(SignupRequest requester) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/meter_reader/signup"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(requester.toJson()),
          )
          .timeout(Duration(seconds: 15));
      if (response.statusCode == 401) {
        handleUnauthorized();
        return null;
      }
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 201 && result['success'] == true) {
        return SignupResponse.fromJson(result);
      }
      throw Exception(result['message']);
    } on SocketException {
      throw Exception("No Internet");
    } on TimeoutException {
      throw Exception("Server timeout");
    }
  }

  static Future<DashboardResponse?> getDashboard() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/dashboard"),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 401) {
        handleUnauthorized();
        return null;
      }

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        return DashboardResponse.fromJson(result);
      }

      throw Exception(result['message']);
    } on SocketException {
      throw Exception("No Internet");
    } on TimeoutException {
      throw Exception("Server Timeout");
    }
  }

  static Future<ConsumerResponse?> getConsumers() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/consumers"),
        headers: {"Authorization": "bearer $token"},
      );
      if (response.statusCode == 401) {
        handleUnauthorized();
        return null;
      }
      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        return ConsumerResponse.fromJson(result);
      }

      throw Exception(result['message']);
    } catch (e) {
      rethrow;
    }
  }

  static Future<ConsumerDetailResponse?> getConsumerDetail(
    int consumerId,
  ) async {
    try {
      final response = await http
          .get(
            Uri.parse("$baseUrl/consumers/$consumerId"),
            headers: {"Authorization": "Bearer $token"},
          )
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 401) {
        handleUnauthorized();
        return null;
      }
      print("DATA IS :  ${response.body}");
      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        return ConsumerDetailResponse.fromJson(result);
      }

      throw Exception(result['message']);
    } catch (e) {
      rethrow;
    }
  }

  static Future<SetReadingResponse?> setReading(
    int consumerId,
    SetReadingRequest request,
  ) async {
    try {
      final uri = Uri.parse("$baseUrl/readings/$consumerId");

      final multipartRequest = http.MultipartRequest('POST', uri);

      multipartRequest.fields['meter_id'] = request.meterId.toString();
      multipartRequest.fields['reader_id'] = request.readerId.toString();
      multipartRequest.fields['meter_type'] = request.meterType;
      multipartRequest.fields['current_reading'] = request.currentReading
          .toString();

      // Photo
      if (request.meterPhoto != null) {
        final mimeType =
            lookupMimeType(request.meterPhoto!.path) ?? 'image/jpeg';
        final mimeTypeSplit = mimeType.split('/');

        multipartRequest.files.add(
          await http.MultipartFile.fromPath(
            'meter_photo',
            request.meterPhoto!.path,
            contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
          ),
        );
      }

      final streamed = await multipartRequest.send().timeout(
        const Duration(seconds: 15),
      );
      final body = await streamed.stream.bytesToString();
      if (streamed.statusCode == 401) {
        handleUnauthorized();
        return null;
      }
      print("status code : ${streamed.statusCode}");
      print("Body : $body");

      final result = jsonDecode(body);

      if (streamed.statusCode == 200 && result['success'] == true) {
        return SetReadingResponse.fromJson(result);
      }

      throw Exception(result['message']);
    } on SocketException {
      throw Exception("No Internet");
    } on TimeoutException {
      throw Exception("Server Timeout");
    }
  }

  static Future<BillResponse?> generateBill(int readingId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/bills/$readingId"),
        headers: {"Authorization": "bearer $token"},
      );
      if (response.statusCode == 401) {
        handleUnauthorized();
        return null;
      }
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        return BillResponse.fromJson(result);
      }

      throw Exception(result['message']);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ReadingHistoryItem>> getHistory() async {
    final response = await http.get(
      Uri.parse("$baseUrl/readings/history"),
      headers: {"Authorization": "Bearer $token"},
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ReadingHistoryResponse.fromJson(result).data;
    }

    throw Exception("Failed");
  }

  static Future<List<BillHistoryItem>> getBillHistory() async {
    final response = await http.get(
      Uri.parse("$baseUrl/bills/history"),
      headers: {"Authorization": "Bearer $token"},
    );

    print('BILL STATUS: ${response.statusCode}');
    print('BILL BODY: ${response.body}');
    print('TOKEN: $token');
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return BillHistoryResponse.fromJson(result).data;
    }
    throw Exception("Failed");
  }

  static Future<ConsumerResponse?> getPendingConsumers() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/consumers/pending"),
        headers: {"Authorization": "Bearer $token"},
      );
      debugPrint('PENDING STATUS: ${response.statusCode}');
      debugPrint('PENDING BODY: ${response.body}');
      if (response.statusCode == 401) {
        handleUnauthorized();
        return null;
      }

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        return ConsumerResponse.fromJson(result);
      }

      throw Exception(result['message']);
    } on SocketException {
      throw Exception("No Internet");
    } on TimeoutException {
      throw Exception("Server Timeout");
    }
  }

  static void handleUnauthorized() {
    GetStorage().erase();
    Get.deleteAll(force: true);
    Get.put(AuthController(), permanent: true);
    Get.offAll(() => LoginPage());
    Get.snackbar(
      "Session Expired",
      "Please login again",
      backgroundColor: AppColors.errorLight,
      colorText: AppColors.error,
    );
  }
}
