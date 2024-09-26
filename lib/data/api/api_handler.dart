
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/error_response.dart';

class HandleResponse {
  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint('Error decoding response body: $e');
    }

    Response response0 = Response(
      body: body,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (response0.statusCode != 200) {
      if (response0.bodyString != null && response0.bodyString!.startsWith('{"error": ')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: errorResponse.error,
        );
      } else if (response0.bodyString != null && response0.bodyString!.startsWith('{message')) {
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: response0.body?['message'],
        );
      } else if (response0.body != null) {
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: response0.body.toString(),
        );
      }
    }

    debugPrint('====> API Response: [${response0.statusCode}] $uri\n${response0.body}');

    return response0;
  }
}
