import 'dart:core';

import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/marketing_details/marketing_details_model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

List<MonthData> convertAllMarketingDetailsToIndividualModels({required List<dynamic> inputData}) {
  Map<String, Map<int, IndividualMarketingDetails>> monthData = {};

  for (var monthEntry in inputData) {
    String month = monthEntry["month"].trim();

    List<dynamic> users = monthEntry["user_data"];

    monthData.putIfAbsent(month, () => {});

    for (var userEntry in users) {
      int userId = userEntry["userId"];
      String user = userEntry["user"];
      List<dynamic> userData = userEntry["data"];

      double totalAmount = userData.fold(0.0, (sum, item) => sum + (item["price"] ?? 0).toDouble());

      monthData[month]!.update(
        userId,
        (existingUser) => IndividualMarketingDetails(
          userId: userId,
          user: user,
          totalAmount: existingUser.totalAmount + totalAmount,
        ),
        ifAbsent: () => IndividualMarketingDetails(userId: userId, user: user, totalAmount: totalAmount),
      );
    }
  }

  return monthData.entries.map((entry) {
    return MonthData(
      month: entry.key,
      data: entry.value.values.toList(),
    );
  }).toList();
}

String? totalAmountCounter({List<IndividualMarketingDetails>? data}) {
  macaPrint("data: $data");

  return data?.fold(0.0, (sum, item) => sum + (item.totalAmount).toDouble()).toString();
}

Future<List<MonthlyData>> getMonthlyIndividualMarketingList() async {
  dynamic response = await ApiService().apiCallService(endpoint: GetUrl().marketingDetails, method: ApiType().get);
  final responseData = AppFunction().macaApiResponsePrintAndGet(data: response)["data"] as List<dynamic>;
  final meterReadingList = responseData.reversed.map((e) => MonthlyData.fromJson(e)).toList();
  return meterReadingList;
}

caseConverter({dynamic data}) {
  return data.toString().toUpperCase();
}
