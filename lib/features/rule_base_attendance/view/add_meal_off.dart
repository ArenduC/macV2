import 'package:flutter/material.dart';
import 'package:maca/features/rule_base_attendance/service/api_service.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/helper/maca_global_helper.dart';
import 'package:maca/page/marketing_add_page.dart';
import 'package:maca/widget/app_common_widget.dart';

class AddMealOff extends StatefulWidget {
  final BuildContext? context;
  const AddMealOff({super.key, this.context});

  @override
  State<AddMealOff> createState() => _AddMealOffState();
}

class _AddMealOffState extends State<AddMealOff> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  dynamic shift;
  dynamic startShift = false;
  dynamic endShift = false;
  dynamic viewState = 6;
  dynamic loginData;
  dynamic marketingStatus;

  // This method for getting date from user input
  Future<void> datePickerHandle(dynamic type, dynamic selectedShift) async {
    macaPrint(type);
    DateTime now = DateTime.now();
    DateTime? datePicker = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(2020), lastDate: DateTime(now.year + 1));
    if (datePicker != null) {
      switch (type) {
        case "Start Date":
          startDateController.text = datePicker.toString().split(" ")[0];
          break;
        case "End Date":
          endDateController.text = datePicker.toString().split(" ")[0];
          break;
      }
    }
  }

  /* This for marketing shift selection 
   1. It contains two option like "Start Date" and "End Date"
*/
  Future<void> selectedShift(dynamic type, dynamic selectedShift) async {
    macaPrint(selectedShift, "selectedShift");
    setState(() {
      shift = selectedShift;
      if (type != null) {
        switch (type) {
          case "Start Date":
            startShift = selectedShift;
            break;
          case "End Date":
            endShift = selectedShift;
            break;
        }
      }
    });
  }

  Future<dynamic> marketingStatusUpdate() async {
    var loginData = await getLocalStorageData("loginDetails");

    dynamic jsonBody = {
      "borderName": loginData[0]["user_name"],
      "borderId": loginData[0]["user_id"],
      "startDate": startDateController.text,
      "endDate": endDateController.text,
      "startShift": mealOffBooleanConverter(startShift),
      "endShift": mealOffBooleanConverter(endShift)
    };

    macaPrint("addShift$jsonBody");

    await insertMealAbsentDetail(widget.context!, jsonBody);
  }

  getViewController(dynamic data) {
    macaPrint(data);
    switch (data) {
      case 0:
        return const SuccessView();
      case 1:
        return marketDetailsView(marketingStatus["status"]);
      case 5:
        return marketDetailsView(9);
      case 6:
        return inputSegment(startDateController, endDateController, shift, datePickerHandle, selectedShift, marketingStatusUpdate);
      default:
        return inputSegment(startDateController, endDateController, shift, datePickerHandle, selectedShift, marketingStatusUpdate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // Animation duration
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: getViewController(viewState),
        key: ValueKey<int>(viewState), // Unique key for AnimatedSwitcher
      ),
    );
  }
}
