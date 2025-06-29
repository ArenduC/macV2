import 'package:flutter/material.dart';
import 'package:maca/common/snack_bar/enum/snack_bar_type.dart';
import 'package:maca/common/snack_bar/model/snack_bar_model.dart';
import 'package:maca/styles/colors/app_colors.dart';

macaSnackBar(BuildContext context, SnackBarType snackBarType, dynamic message) {
  final data = snackBarData[snackBarType]!;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.themeWhite.withOpacity(0),
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(bottom: 60),
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8)), color: data.color.withOpacity(.3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              data.icon,
              color: data.color,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.message,
                  style: TextStyle(color: data.color, fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
