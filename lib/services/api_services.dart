import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sample1/models/login_model.dart';
import 'package:sample1/models/signup_model.dart';

import '../models/consumer_detail_model/bil_history_model.dart';
import '../models/consumer_detail_model/bill_model.dart';
import '../models/consumer_detail_model/consumer_detail_response.dart';
import '../models/consumer_detail_model/reading_history_model.dart';
import '../models/consumer_detail_model/set_reading_model.dart';
import '../models/consumer_model/consumer_response.dart';
import '../models/dashboard_controller/dashboard_controller.dart';

import 'package:mime/mime.dart';

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

  // static Future<ConsumerResponse?> getConsumers() async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse("$baseUrl/consumers"))
  //         .timeout(Duration(seconds: 15));
  //     print(response.body);
  //     final result = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && result['success'] == true) {
  //       return ConsumerResponse.fromJson(result);
  //     }
  //     throw Exception(result['message']);
  //   } on SocketException {
  //     throw Exception("No Internet");
  //   } on TimeoutException {
  //     throw Exception("Server timeout");
  //   }
  // }
  //
  // static Future<ConsumerPreBillResponse?> getConsumersPreviousBill(
  //   int consumerId,
  // ) async {
  //   try {
  //     final response = await http
  //         .get(
  //           Uri.parse(
  //             "$baseUrl/consumers/getConsumersPreviousBill/${consumerId}",
  //           ),
  //         )
  //         .timeout(Duration(seconds: 15));
  //     print(response.body);
  //     final result = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && result['success'] == true) {
  //       return ConsumerPreBillResponse.fromJson(result);
  //     }
  //     throw Exception(result['message']);
  //   } on SocketException {
  //     throw Exception("No Internet");
  //   } on TimeoutException {
  //     throw Exception("Server timeout");
  //   }
  // }
  //
  // static Future<ReadingResponse> setReading(SetReadingRequest requester,int consumerId) async {
  //   try {
  //     final response = await http
  //         .post(Uri.parse("$baseUrl/consumers/reading/$consumerId"),
  //         headers: {"Content-Type":"application/json",},
  //       body: jsonEncode(requester)
  //     )
  //         .timeout(Duration(seconds: 15));
  //     print(response.body);
  //     final result = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && result['success'] == true) {
  //       return ReadingResponse.fromJson(result);
  //     }
  //     throw Exception(result['message']);
  //   } on SocketException {
  //     throw Exception("No Internet");
  //   } on TimeoutException {
  //     throw Exception("Server timeout");
  //   }
  // }
  //
  // static Future<CommonResponseModel> setBilling(String meterType,int readingId) async {
  //   try {
  //     final response = await http
  //         .post(Uri.parse("$baseUrl/bills/bill/$readingId"),
  //         headers: {"Content-Type":"application/json",},
  //         body: jsonEncode({
  //         "meter_type":meterType
  // })
  //     )
  //         .timeout(Duration(seconds: 15));
  //     print(response.body);
  //     final result = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && result['success'] == true) {
  //       return CommonResponseModel.fromJson(result);
  //     }
  //     throw Exception(result['message']);
  //   } on SocketException {
  //     throw Exception("No Internet");
  //   } on TimeoutException {
  //     throw Exception("Server timeout");
  //   }
  // }

  static Future<DashboardResponse?> getDashboard() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/dashboard"),
        headers: {"Authorization": "Bearer $token"},
      );

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
  //
  // static Future<SetReadingResponse?> setReading(
  //   int consumerId,
  //   SetReadingRequest request,
  // ) async {
  //   try {
  //     final response = await http
  //         .post(
  //           Uri.parse("$baseUrl/readings/$consumerId"),
  //           headers: {
  //             "Content-Type": "application/json",
  //             "Authorization": "bearer $token",
  //           },
  //           body: jsonEncode(request.toJson()),
  //         )
  //         .timeout(const Duration(seconds: 15));
  //     print(response.body);
  //     final result = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 && result['success'] == true) {
  //       return SetReadingResponse.fromJson(result);
  //     }
  //
  //     throw Exception(result['message']);
  //   } on SocketException {
  //     throw Exception("No Internet");
  //   } on TimeoutException {
  //     throw Exception("Server Timeout");
  //   }
  // }

  static Future<SetReadingResponse?> setReading(
    int consumerId,
    SetReadingRequest request,
  ) async {
    try {
      final uri = Uri.parse("$baseUrl/readings/$consumerId");

      //MultipartRequest
      final multipartRequest = http.MultipartRequest('POST', uri);

      // Auth header
      // multipartRequest.headers['Authorization'] = 'Bearer $token';

      // Text fields
      multipartRequest.fields['meter_id'] = request.meterId.toString();
      multipartRequest.fields['reader_id'] = request.readerId.toString();
      multipartRequest.fields['current_reading'] = request.currentReading
          .toString();

      // Photo
      if (request.meterPhoto != null) {
        final mimeType =
            lookupMimeType(request.meterPhoto!.path) ?? 'image/jpeg';
        final mimeTypeSplit = mimeType.split('/');
        // multipartRequest.files.add(
        //   await http.MultipartFile.fromPath(
        //     'meter_photo',
        //     contentType: MediaType(
        //       'image',
        //       'jpeg',
        //     ), // backend: upload.single('meter_photo')
        //     request.meterPhoto!.path,
        //   ),
        // );
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

  static Future<List<HistoryItem>> getHistory() async {
    final response = await http.get(Uri.parse("$baseUrl/readings/history"),
        headers: {"Authorization": "Bearer $token"});

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return HistoryResponse.fromJson(result).data;
    }

    throw Exception("Failed");
  }

  // static Future<CommonResModel> editReading(
  //   int currentReading,
  //   int readingId,
  // ) async {
  //   print(readingId);
  //   final response = await http.put(
  //     Uri.parse("$baseUrl/readings/editReading/$readingId"),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({"current_reading": currentReading}),
  //   );
  //
  //   final result = jsonDecode(response.body);
  //
  //   if (response.statusCode == 200) {
  //     return CommonResModel.fromJson(result);
  //   }
  //   throw Exception("Failed");
  // }

  static Future<List<BillHistoryItem>> getBillHistory() async {
    final response = await http.get(Uri.parse("$baseUrl/bills/history"),
        headers: {"Authorization": "Bearer $token"});

    print('BILL STATUS: ${response.statusCode}');
    print('BILL BODY: ${response.body}');
    print('TOKEN: $token');
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return BillHistoryResponse.fromJson(result).data;
    }
    throw Exception("Failed");
  }
}
