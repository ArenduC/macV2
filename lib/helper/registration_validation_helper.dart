import 'package:flutter/material.dart';

bool validateInput(BuildContext context, Map<String, dynamic> data) {
  String? message;

  // Check if any field is empty
  if (data.values.any((value) => value == null || value.toString().trim().isEmpty)) {
    message = "All fields are required.";
  }
  // Email validation
  else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(data["email"])) {
    message = "Please enter a valid email address.";
  }
  // Phone number validation (must be exactly 10 digits)
  else if (!RegExp(r"^\d{10}$").hasMatch(data["phoneNo"])) {
    message = "Phone number must be exactly 10 digits.";
  }
  // Password validation (at least 3 conditions: min length, uppercase, number, special char)
  else {
    String password = data["password"];
    bool hasUpper = password.contains(RegExp(r'[A-Z]'));
    bool hasLower = password.contains(RegExp(r'[a-z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    bool hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= 8;

    int conditionsMet = [hasUpper, hasLower, hasNumber, hasSpecial, hasMinLength].where((condition) => condition).length;

    if (conditionsMet < 3) {
      message = "Password must meet at least 3 conditions:\n- Uppercase letter\n- Lowercase letter\n- Number\n- Special character\n- Min 8 characters";
    }
  }

  // If there's an error, show a Snackbar
  if (message != null) {
    showSnackbar(context, message);
    return false;
  }
  return true;
}

// Snackbar Helper
void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ),
  );
}
