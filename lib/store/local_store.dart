import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListOfStoreKey {
  static const String loginDetails = "loginDetails";
  static const String borderDetails = "borderDetails";
  static const String loginStatus = "loginStatus";
  static const String fcmToken = "fcmToken";
  static const String inUsMrDetails = "inUsMrDetails";
  static const String activeBorderList = "activeBorderList";
  static const String activeMeterList = "activeMeterList";
  static const String getMonthlyMeterReadings = "getMonthlyMeterReadings";
  static const String expenditureDetails = "expenditureDetails";
  static const String notificationList = "notificationList";
  //individualMarketingDetails
  static const Map<String, String> allKeys = {
    "loginDetails": loginDetails,
    "borderDetails": borderDetails,
    "loginStatus": loginStatus,
    "fcmToken": fcmToken,
    "inUsMrDetails": inUsMrDetails,
    "activeBorderList": activeBorderList,
    "activeMeterList": activeMeterList,
    "getMonthlyMeterReadings": getMonthlyMeterReadings,
    "expenditureDetails": expenditureDetails,
    "notificationList": notificationList,
  };
}

class LocalStore {
// Create storage
  final storage = const FlutterSecureStorage();

// Read value
  Future<dynamic> getStore(dynamic key) async {
    if (ListOfStoreKey.allKeys.containsKey(key)) {
      String? value = await storage.read(key: key);
      if (value != null) {
        return jsonDecode(value);
      } else {
        return null;
      }
    }
    return null;
  }

// Delete value
  deleteStore(dynamic key) async {
    await storage.delete(key: key);
  }

// Write value
  Future<dynamic> setStore(dynamic key, dynamic value) async {
    if (ListOfStoreKey.allKeys.containsKey(key)) {
      await storage.write(key: key, value: jsonEncode(value));
    }
  }
}
