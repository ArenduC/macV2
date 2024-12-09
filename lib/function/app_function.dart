// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maca/page/expend_add_page.dart';
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
  }
}

// This is for showing modal based on screen
getModalItem(dynamic data) {
  switch (data) {
    case 0:
      return const ExpendAddPage();
    case 1:
      return const MarketingAddPage();
    default:
      return const MarketingAddPage();
  }
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
  DateTime parsedDate = DateTime.parse(dateTime);
  final day = parsedDate.day;
  final daySuffix = getDaySuffix(day);
  final month = getMonthName(parsedDate.month);

  return {
    'Day': '$day$daySuffix',
    'Month': month,
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
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return monthNames[month - 1];
}

class AppFunction {
  macaApiResponsePrintAndGet(dynamic data, [dynamic extractData]) {
    if (data.statusCode == 200) {
      dynamic response = jsonDecode(data.body);
      if (extractData == "data") {
        print("Api  response: ${response["data"]}");
        return response["data"];
      } else {
        print("Api response: $response");
        return response;
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
        'is_active':
            activeBeds.contains(bed['user_bed']), // True if present in userBeds
      };
    }).toList();
  }
}
