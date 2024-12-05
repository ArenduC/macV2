// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:maca/store/local_store.dart';

macaPrint(dynamic data, [dynamic message]) {
  print("  ${message ?? "macaPrint:"}  $data");
}

Future getLocalStorageData(dynamic key) async {
  dynamic data = await LocalStore().getStore(key);
  macaPrint(data, "Local store data $key :");
  return data;
}

getMarketStatus(dynamic data) {
  switch (data) {
    case 0:
      return "Idle";
    case 1:
      return "Ongoing";
    case 2:
      return "Expired";
    case 3:
      return "Upcoming";
    default:
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
  macaPrint(dynamic data, [dynamic message]) {
    print("  ${message ?? "macaPrint:"}  $data");
  }

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
