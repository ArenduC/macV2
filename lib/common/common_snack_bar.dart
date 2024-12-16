import 'package:flutter/material.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class CommonSnackBar extends StatefulWidget {
  const CommonSnackBar({super.key});

  @override
  State<CommonSnackBar> createState() => _CommonSnackBarState();
}

class _CommonSnackBarState extends State<CommonSnackBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.theme,
          borderRadius: BorderRadius.circular(11),
          boxShadow: const [AppBoxShadow.defaultBoxShadow]),
      child: const Row(
        children: [Text("This is snack bar")],
      ),
    );
  }
}
