// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/features/add_electric_bill/view/meter_list_view.dart';
import 'package:maca/features/add_electric_bill/view/previous_meter_reading_view.dart';
import 'package:maca/features/add_electric_bill/view/segment_add_view.dart';
import 'package:maca/features/add_electric_bill/view/user_list_view.dart';
import 'package:maca/features/marketing_details/marketing_details_model.dart';
import 'package:maca/features/marketing_details/view/individual_details.dart';
import 'package:maca/features/rule_base_attendance/view/add_meal_off.dart';
import 'package:maca/modal/meal_ofon_modal.dart';
import 'package:maca/features/add_marketing_details/view/expend_add_page.dart';
import 'package:maca/page/marketing_add_page.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/colors/app_colors.dart';

// This function is to print data for the whole project
macaPrint(dynamic data, [dynamic message]) {
  print("  ${message ?? "macaPrint:"}  $data");
}

// For fetching data from local storage using key
Future getLocalStorageData(dynamic key) async {
  dynamic data = await LocalStore().getStore(key);
  macaPrint(data, "Local store data $key :");
  return data;
}

// To get the booking status
getMarketStatus(dynamic data) {
  switch (data) {
    case 0:
      return "Idle";
    case 1:
      return "Ongoing";
    case 2:
      return "Upcoming";
    case 3:
      return "Completed";
    default:
      return "Please wait...";
  }
}

// This is for showing modal based on screen
getModalItem(
  dynamic data, {
  BuildContext? context,
  int? selectedMeterId,
  List<ActiveUser>? activeUserList,
  List<ActiveMeter>? activeMeterList,
  List<ItemData>? individualMarketing,
  List<MeterReadingInputModel>? meterReadingDetails,
  Function(List<ActiveUser>)? onUserSelected,
  Function(List<ActiveMeter>)? onMeterSelected,
}) {
  macaPrint("itemIndex$data");
  switch (data) {
    case 0:
      return const ExpendAddPage();
    case 1:
      return const MarketingAddPage();
    case 2:
      return UserListView(
        activeUserList: activeUserList,
        onDone: onUserSelected,
      );
    case 4:
      return MeterListView(
        activeMeterList: activeMeterList,
        selectedMeterId: selectedMeterId,
        onDone: onMeterSelected,
      );
    case 5:
      return PreviousMeterReadingView(
        selectedMeterId: selectedMeterId,
      );
    case 6:
      return IndividualDetails(individualMarketing: individualMarketing);
    case 7:
      return AddMealOff(context: context);
    case 3:
      return const SegmentAddView();
    default:
      return const MealOfOnModal();
  }
}

void showBedSelectionModal(
  BuildContext context,
  dynamic value, {
  int? selectedMeterId,
  List<ActiveUser>? selectedUsers,
  List<ActiveMeter>? activeMeterList,
  List<MeterReadingInputModel>? meterReadingDetails,
  List<ItemData>? individualMarketing,
  Function(List<ActiveUser>)? onUserSelected,
  Function(List<ActiveMeter>)? onMeterSelected,
}) {
  macaPrint("selectedMeterIdOnSheBedSelectionModal$selectedMeterId");
  showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backGround,
      isScrollControlled: true, // Allows the modal to take more space
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Optional rounded corners
      ),
      builder: (context) {
        return GestureDetector(
          onTap: () => {
            FocusScope.of(context).unfocus(),
          },
          // Dismiss keyboard
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: getModalItem(
                  context: context,
                  value,
                  activeUserList: selectedUsers,
                  selectedMeterId: selectedMeterId,
                  individualMarketing: individualMarketing,
                  meterReadingDetails: meterReadingDetails,
                  onUserSelected: onUserSelected,
                  onMeterSelected: onMeterSelected,
                  activeMeterList: activeMeterList),
            ),
          ),
        );
      });
}

// It is used for fetching booking status color
Color getMarketStatusColor(dynamic data) {
  switch (data) {
    case 0:
      return AppColors.idle;
    case 1:
      return AppColors.ongoing;
    case 2:
      return AppColors.upcoming;
    case 3:
      return AppColors.completed;
    default:
      return AppColors.themeGray;
  }
}

IconData getCurrentPageIcon(dynamic data) {
  switch (data) {
    case 0:
      return Icons.note_alt_rounded;
    case 1:
      return Icons.edit_calendar;
    default:
      return Icons.wine_bar_outlined;
  }
}

formatCustomDate(dynamic dateTime) {
  // Ensure proper DateTime conversion
  DateTime parsedDate;
  if (dateTime is String) {
    parsedDate = DateTime.parse(dateTime);
  } else if (dateTime is int) {
    parsedDate = DateTime.fromMillisecondsSinceEpoch(dateTime);
  } else if (dateTime is DateTime) {
    parsedDate = dateTime;
  } else {
    throw ArgumentError('Invalid date format');
  }

  final day = parsedDate.day;
  final daySuffix = getDaySuffix(day);
  final month = getMonthName(parsedDate.month);
  final year = parsedDate.year;

  return {
    'Day': '$day$daySuffix',
    'Month': month,
    'Year': year.toString(),
  };
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String getMonthName(int month) {
  const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  return monthNames[month - 1];
}

class AppFunction {
  macaApiResponsePrintAndGet({
    required dynamic data,
    BuildContext? context, // add context to show snackbar
    bool? snackBarView,
    dynamic snackBarType,
    dynamic snackBarMessage,
    dynamic extractData,
  }) {
    print("Api response: $data");
    if (data == "") {
      if (snackBarView == true && context != null) {
        final message = snackBarMessage ?? "Success";
        final isError = snackBarType == "error";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.toString()),
            backgroundColor: isError ? Colors.red : Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (data.statusCode == 200) {
        dynamic response = jsonDecode(data.body);

        // ✅ Show SnackBar if requested and context is available
        if (snackBarView == true && context != null) {
          final message = snackBarMessage ?? response["message"] ?? "Success";
          final isError = snackBarType == "error";

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message.toString()),
              backgroundColor: isError ? Colors.red : Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        // ✅ Return extracted data or full response
        if (extractData == "data") {
          print("Api response (data): ${response["data"]}");
          return response["data"];
        } else {
          print("Api response (full): $response");
          return response;
        }
      } else {
        if (snackBarView == true && context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Something went wrong"),
              backgroundColor: Colors.red,
            ),
          );
        }
        print("API Error: ${data.statusCode}");
        return null;
      }
    }
  }

  dynamic createBedStatusList(dynamic userBeds, dynamic allBeds) {
    // Create a set of active user_bed values for quick lookup
    final activeBeds = userBeds.map((bed) => bed['user_bed']).toSet();

    // Map over allBeds and add the is_active key
    return allBeds.map((bed) {
      return {
        ...bed,
        'is_active': !activeBeds.contains(bed['user_bed']), // True if present in userBeds
      };
    }).toList();
  }
}
