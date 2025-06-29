import 'package:flutter/material.dart';
import 'package:maca/common/snack_bar/enum/snack_bar_type.dart';
import 'package:maca/common/snack_bar/view/maca_snack_bar.dart';
import 'package:maca/features/expenditure/model/establishment_item.dart';

emptyExpenditureArrayCheck({BuildContext? context, required List<EstablishmentItem> data}) {
  bool isEmpty = true;
  // ignore: avoid_function_literals_in_foreach_calls
  if (data.isNotEmpty) {
    for (var element in data) {
      if (element.itemName == "" || element.itemAmount == 0.0 || element.itemAmount == null || element.itemName == null) {
        isEmpty = true;
      } else {
        isEmpty = false;
      }
    }
  }

  macaSnackBar(context!, isEmpty ? SnackBarType.warning : SnackBarType.success, "Message");

  return {"status": isEmpty, "code": isEmpty ? 500 : 300};
}
