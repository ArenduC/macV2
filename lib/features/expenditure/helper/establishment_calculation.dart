import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/notifiers/added_border_item_notifier.dart';
import 'package:maca/function/app_function.dart';

establishmentCalculation() {
  List<ExpendBorderItem> finalExpenditureBorderList = [];
  var establishment = establishmentNotifier.value;
  var borderExpenditureDetails = addedBorderListNotifier.value;
  var totalMember = borderExpenditureDetails.length;
  var totalMeal = 0;
  var totalEstablishment = 0;
  var perHeadEstablishment = 0;
  var perMealCharge = 0.0;
  var totalExpenditure = 0;
  var totalGestMeal = 0;

  if (borderExpenditureDetails.isNotEmpty) {
    for (var data in borderExpenditureDetails) {
      totalMeal += data.mealCount;
      totalExpenditure += data.expenditure;
      totalGestMeal += data.gestMeal;
    }
    perMealCharge = double.parse(((totalExpenditure - totalGestMeal) / totalMeal).toStringAsFixed(2));
  }
  if (establishment.isNotEmpty) {
    for (var data in establishment) {
      totalEstablishment += data.itemAmount!.toInt();
    }
    perHeadEstablishment = totalEstablishment ~/ totalMember;
  }

  if (borderExpenditureDetails.isNotEmpty) {
    for (var data in borderExpenditureDetails) {
      finalExpenditureBorderList.add(ExpendBorderItem(
          id: data.id,
          name: data.name,
          userBedId: data.userBedId,
          isGestMeal: data.isGestMeal,
          mealCount: data.mealCount,
          deposit: data.deposit,
          expenditure: data.expenditure,
          gestMeal: data.gestMeal,
          balance: (data.deposit + data.expenditure) - ((data.mealCount.toDouble() * perMealCharge) + perHeadEstablishment.toDouble()).toInt(),
          totalExpend: ((data.mealCount.toDouble() * perMealCharge) + perHeadEstablishment.toDouble()).toInt()));
    }
  }

  macaPrint("totalMeal: $totalMeal, totalMember: $totalMember, totalEstablishment: $totalEstablishment , perHeadEstablishment: $perHeadEstablishment");
  macaPrint("totalExpenditure: $totalExpenditure, totalGestMeal: $totalGestMeal, perMealCharge: $perMealCharge");
  macaPrint("establishment: $establishment borderExpenditureDetails: $borderExpenditureDetails finalExpenditureBorderList: $finalExpenditureBorderList ");

  return {
    "totalMeal": totalMeal,
    "totalMember": totalMember,
    "totalEstablishment": totalEstablishment,
    "totalMarketing": totalExpenditure,
    "establishmentList": establishment,
    "userFinalList": finalExpenditureBorderList
  };
}
