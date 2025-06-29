// 2. Define the model class

import 'package:flutter/material.dart';
import 'package:maca/common/snack_bar/enum/snack_bar_type.dart';

class SnackBarModel {
  final Color color;
  final IconData icon;
  final String message;

  const SnackBarModel({
    required this.color,
    required this.icon,
    required this.message,
  });
}

// 3. Map enum to SnackBarModel
final Map<SnackBarType, SnackBarModel> snackBarData = {
  SnackBarType.success: const SnackBarModel(
    color: Colors.green,
    icon: Icons.check_circle,
    message: "Operation successful!",
  ),
  SnackBarType.error: const SnackBarModel(
    color: Colors.red,
    icon: Icons.error,
    message: "Something went wrong!",
  ),
  SnackBarType.warning: const SnackBarModel(
    color: Colors.orange,
    icon: Icons.warning_rounded,
    message: "Please be cautious!",
  ),
};
