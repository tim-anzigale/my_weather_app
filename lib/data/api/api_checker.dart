// Suggested code may be subject to a license. Learn more: ~LicenseLog:257204092.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:662451162.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1137005783.
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class ApiChecker {
  static const String unauthorizedTitle = 'Unauthorized';
  static const String unauthorizedMessage = 'Invalid API key. Please check your credentials.';
  static const String forbiddenTitle = 'Forbidden';
  static const String forbiddenMessage = 'Access to the weather data is forbidden.';
  static const String locationNotFoundTitle = 'Location Not Found';
  static const String locationNotFoundMessage = 'Please try a different city.';
  static const String serverErrorTitle = 'Server Error';
  static const String serverErrorMessage = 'Please try again later.';
  static const String serviceUnavailableTitle = 'Service Unavailable';
  static const String serviceUnavailableMessage = 'Weather service is currently unavailable. Try again later.';
  static const String errorTitle = 'Error';


  static void checkApiResponse(BuildContext context, {required int statusCode, required String message}) {
    if (statusCode != 200) {
      String title;
      String msg;
      ContentType contentType;

    switch (statusCode) {
        case 401:
          title = unauthorizedTitle;
          msg = unauthorizedMessage;
          contentType = ContentType.failure;
        break;
        case 403:
          title = forbiddenTitle;
          msg = forbiddenMessage;
          contentType = ContentType.warning;
        break;
        case 404:
          title = locationNotFoundTitle;
          msg = locationNotFoundMessage;
          contentType = ContentType.warning;
        break;
        case 500:
          title = serverErrorTitle;
          msg = serverErrorMessage;
          contentType = ContentType.failure;
        break;
        case 503:
          title = serviceUnavailableTitle;
          msg = serviceUnavailableMessage;
          contentType = ContentType.warning;
        break;
        default:
          title = errorTitle;
          msg = 'An unexpected error occurred. Status code: $statusCode';
          contentType = ContentType.help;
      }

        _showAwesomeSnackBar(
          context: context,
        title: title,
        message: msg,
        contentType: contentType,
        );
    }
  }

  static void _showAwesomeSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        color: Colors.blueAccent,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
  }
