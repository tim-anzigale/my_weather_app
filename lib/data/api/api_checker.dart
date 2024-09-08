import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class ApiChecker {
  static void checkApiResponse(BuildContext context, {required int statusCode, required String message}) {
    switch (statusCode) {
      case 200: // Success
        // No action needed for a successful response
        break;
      case 401: // Unauthorized
        _showAwesomeSnackBar(
          context: context,
          title: 'Unauthorized',
          message: 'Invalid API key. Please check your credentials.',
          contentType: ContentType.failure,
        );
        break;
      case 403: // Forbidden
        _showAwesomeSnackBar(
          context: context,
          title: 'Forbidden',
          message: 'Access to the weather data is forbidden.',
          contentType: ContentType.warning,
        );
        break;
      case 404: // Not Found
        _showAwesomeSnackBar(
          context: context,
          title: 'Location Not Found',
          message: 'Please try a different city.',
          contentType: ContentType.warning,
        );
        break;
      case 500: // Server Error
        _showAwesomeSnackBar(
          context: context,
          title: 'Server Error',
          message: 'Please try again later.',
          contentType: ContentType.failure,
        );
        break;
      case 503: // Service Unavailable
        _showAwesomeSnackBar(
          context: context,
          title: 'Service Unavailable',
          message: 'Weather service is currently unavailable. Try again later.',
          contentType: ContentType.warning,
        );
        break;
      default: // Other errors
        _showAwesomeSnackBar(
          context: context,
          title: 'Error',
          message: 'An unexpected error occurred. Status code: $statusCode',
          contentType: ContentType.help,
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
        color: Colors.blueAccent, // Customize the color of the snackbar
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
