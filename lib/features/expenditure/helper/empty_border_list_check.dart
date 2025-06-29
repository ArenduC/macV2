import 'package:flutter/material.dart';
import 'package:maca/common/snack_bar/enum/snack_bar_type.dart';
import 'package:maca/common/snack_bar/view/maca_snack_bar.dart';
import 'package:maca/features/expenditure/model/border_item.dart';

Map<String, dynamic> emptyAddedBorderArrayCheck({
  required BuildContext context,
  required List<AddedBorderItem> data,
}) {
  bool isInvalid = false;

  // Check if there are any guest meal users
  bool hasGestMealUsers = data.any((item) => item.isGestMeal == true);

  for (var item in data) {
    if (item.name.trim().isEmpty || item.userBedId == 0 || item.mealCount == 0 || item.expenditure == 0 || (hasGestMealUsers && item.isGestMeal && item.gestMeal == 0)) {
      isInvalid = true;
      break;
    }
  }

  macaSnackBar(
    context,
    isInvalid ? SnackBarType.warning : SnackBarType.success,
    isInvalid ? "Some users have missing or invalid data." : "All border entries are valid.",
  );

  return {
    "status": isInvalid,
    "code": isInvalid ? 500 : 300,
  };
}
