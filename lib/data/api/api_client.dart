import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/api/api_handler.dart';
import 'package:weather_app/utils/environment.dart'; // Ensure the correct import path


class ApiClient extends GetxService {
  late String baseUrl;
  late SharedPreferences sharedPreferences;
  final int timeoutInSeconds = 30;

  String token = '';
  late Map<String, String> _mainHeaders;
  RxBool loadingLogin = false.obs;

  ApiClient({
    required this.baseUrl,
    required this.sharedPreferences,
  }) {
    // Initialize the base URL correctly
    baseUrl = Environment.openWeatherBaseUrl;

    // Remove any trailing slashes from baseUrl to avoid malformed URL issues
    if (baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }

    // Initialize headers with user token
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

  void updateToken(String token) {
    this.token = token;
    updateHeader(token);
  }

  // GET request with parameters
  Future<Response> getWithParamData(
    String uri, {
    required Map<String, String> queryParams,
  }) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams');

      // Correctly construct the full URI with query parameters
      http.Response response = await http
          .get(
            Uri.parse(uri).replace(queryParameters: queryParams),
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      // Use the handleResponse method from HandleResponse class
      return HandleResponse().handleResponse(response, uri);
    } on TimeoutException {
      return _handleError('The operation timed out');
    } on SocketException {
      return _handleError('No internet connection');
    } catch (e) {
      debugPrint('Unexpected error occurred: $e');
      return _handleError('An unexpected error occurred');
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      final fullUri = Uri.parse(uri);
      debugPrint('====> API Call: $fullUri\nHeader: $_mainHeaders\nBody: $body');
      http.Response response = await http.post(
        fullUri,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      // Use the handleResponse method from HandleResponse class
      return HandleResponse().handleResponse(response, uri);
    } on TimeoutException {
      return _handleError('The operation timed out');
    } on SocketException {
      return _handleError('No internet connection');
    } catch (e) {
      debugPrint('Unexpected error occurred: $e');
      return _handleError('An unexpected error occurred');
    }
  }

  Response _handleError(String message) {
    debugPrint('Error: $message');
    return const Response(
      statusCode: 1,
      statusText: 'No internet connection',
    );
  }

  String getUserToken() {
    return sharedPreferences.getString('token') ?? '';
  }
}
