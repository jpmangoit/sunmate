import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message, bool isError, {DismissDirection dismissDirection = DismissDirection.up}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: dismissDirection,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          left: 10,
          right: 10),
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green, // Adjust colors as per your needs
      behavior: SnackBarBehavior.floating,
    ),
  );
}
