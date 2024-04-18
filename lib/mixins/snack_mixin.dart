import 'package:flutter/material.dart';

abstract class SnackMixin {
  void showError(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void showSuccess(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e),
        backgroundColor: Colors.green,
      ),
    );
  }
}
