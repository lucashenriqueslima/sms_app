import 'package:flutter/material.dart';

class SnackBarWidget {
  static SnackBar alert(message, type) {
    return SnackBar(
        duration: const Duration(seconds: 3),
        elevation: 10.0,
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: getColorSnackBar(type));
  }

  static Color? getColorSnackBar(type) {
    switch (type) {
      case "success":
        return Colors.green[600];

      case "warning":
        return Colors.orange[800];

      case "info":
        return Colors.blue[700];

      case "error":
        return Colors.red[800];
    }
  }
}
