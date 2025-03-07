import 'package:flutter/material.dart';
import 'package:maca/helper/registration_validation_helper.dart';
import 'package:maca/model/data_model.dart';

addExpense({ExpenseData? data}) {}

emptyObjectCheck({required ExpenseData data}) {
  if (data.item == "" || data.amount == 0) {
    return true;
  } else {
    return false;
  }
}

emptyArrayCheck({BuildContext? context, required List<ExpenseData> data}) {
  bool isEmpty = false;
  // ignore: avoid_function_literals_in_foreach_calls
  data.forEach((element) {
    if (element.item == "" || element.amount == 0.0) {
      isEmpty = true;
    }
  });

  return {"status": isEmpty, "code": isEmpty ? 500 : 300};
}
