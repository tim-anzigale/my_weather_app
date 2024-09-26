import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/api/api_handler.dart';
import 'package:weather_app/utils/environment.dart'; // Ensure the correct import path

// Suggested code may be subject to a license. Learn more: ~LicenseLog:161448088.
class ApiClient extends GetxService {
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  static const String tokenKey = 'token';
  static const int timeoutInSeconds = 30;
  static const String noInternetConnection = 'No internet connection';
  static const String unexpectedError = 'An unexpected error occurred';
  static const String operationTimedOut = 'The operation timed out';

  late String baseUrl;
  late SharedPreferences sharedPreferences;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.baseUrl, required this.sharedPreferences}) {
    baseUrl = Environment.openWeatherBaseUrl;
    if (baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }
    _mainHeaders = {
      contentType: applicationJson,
      authorization: '$bearer ${getUserToken()}'
    };
  }

  void updateHeader(String? token) {
    _mainHeaders = {
      contentType: applicationJson,
      authorization: '$bearer $token'
    };
  }

  void updateToken(String? token) {
    this.token = token;
    updateHeader(token);
  }

  Future<Response> getWithParamData(
    String uri, {
    required Map<String, String> queryParams,
  }) async {
    try {
      debugPrint(
          '====> API Call: $uri\nHeader: $_mainHeaders\nParams: $queryParams');
      final response = await http
          .get(
            Uri.parse(uri).replace(queryParameters: queryParams),
            headers: _mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return HandleResponse().handleResponse(response, uri);
    } on TimeoutException {
      return _handleError(operationTimedOut);
    } on SocketException {
      return _handleError(noInternetConnection);
    } catch (e) {
      debugPrint('Unexpected error occurred: $e');
      return _handleError(unexpectedError);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final fullUri = Uri.parse(uri);
      debugPrint(
          '====> API Call: $fullUri\nHeader: $_mainHeaders\nBody: $body');
      final response = await http
          .post(
        fullUri,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return HandleResponse().handleResponse(response, uri);
    } on TimeoutException {
      return _handleError(operationTimedOut);
    } on SocketException {
      return _handleError(noInternetConnection);
    } catch (e) {
      debugPrint('Unexpected error occurred: $e');
      return _handleError(unexpectedError);
    }
  }

  Response _handleError(String message) {
    debugPrint('Error: $message');
    return const Response(
      statusCode: 1,
      statusText: noInternetConnection,
    );
  }

  String? getUserToken() {
    return sharedPreferences.getString(tokenKey);
  }
}

