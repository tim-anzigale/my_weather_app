import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_app/utils/environment.dart';

class ApiClient extends GetxService {
  late String baseUrl = Environment.openWeatherBaseUrl;
  late SharedPreferences sharedPreferences;
  final int timeoutInSeconds = 30;

  String token = '';
  late Map<String, String> _mainHeaders;
  RxBool loadingLogin = false.obs;

  ApiClient({
    required this.baseUrl,
    required this.sharedPreferences,
  }) {
    baseUrl = Environment.openWeatherBaseUrl;

    _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${getUserToken()}',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query}) async {
    try {
      final fullUri = Uri.parse('$baseUrl$uri').replace(queryParameters: query);
      debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders');
      http.Response response = await http.get(
        fullUri,
        headers: _mainHeaders,
      ).timeout(
        Duration(seconds: timeoutInSeconds),
      );

      return handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: 'No internet connection',
      );
    }
  }

  Future<Response> getWithParamData(String uri, {required Map<String, String> queryParams}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams');
      final fullUri = Uri.parse('$baseUrl$uri').replace(queryParameters: queryParams);
      http.Response response = await http.get(
        fullUri,
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      debugPrint('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: 'No internet connection',
      );
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      final fullUri = Uri.parse('$baseUrl$uri');
      debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders\nBody: $body');
      http.Response response = await http.post(
        fullUri,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: 'No internet connection',
      );
    }
  }

  Future<Response> postWithParamsData(String uri, {required Map<String, String> queryParams}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams');
      final fullUri = Uri.parse('$baseUrl$uri').replace(queryParameters: queryParams);
      http.Response response = await http.post(
        fullUri,
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      debugPrint('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: 'No internet connection',
      );
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      final fullUri = Uri.parse('$baseUrl$uri');
      debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders\nBody: $body');
      http.Response response = await http.put(
        fullUri,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: 'No internet connection',
      );
    }
  }

  Future<Response> patchData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      final fullUri = Uri.parse('$baseUrl$uri');
      debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders\nBody: $body');
      http.Response response = await http.patch(
        fullUri,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: 'No internet connection',
      );
    }
  }

  Future<Response> patchWithParamsData(String uri, {required Map<String, String> queryParams, required Map<String, dynamic> body}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams\nBody: $body');
      final fullUri = Uri.parse('$baseUrl$uri').replace(queryParameters: queryParams);
      String bodyJson = jsonEncode(body);

      http.Response response = await http.patch(
        fullUri,
        headers: _mainHeaders,
        body: bodyJson,
      ).timeout(Duration(seconds: timeoutInSeconds));

      debugPrint('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: 'No internet connection',
      );
    }
  }

  Future<Response> deleteData(String uri) async {
    try {
      final fullUri = Uri.parse('$baseUrl$uri');
      debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders');
      http.Response response = await http.delete(
        fullUri,
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: 'No internet connection',
      );
    }
  }

  Response handleResponse(http.Response response, String uri) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Response(
        body: jsonDecode(response.body),
        statusCode: response.statusCode,
      );
    } else {
      return Response(
        statusCode: response.statusCode,
        statusText: 'Error: ${response.reasonPhrase}',
        body: jsonDecode(response.body),
      );
    }
  }

  String getUserToken() {
    return sharedPreferences.getString('token') ?? '';
  }
}
