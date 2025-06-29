// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/rule_base_attendance/model/mealsInformation.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

Future<dynamic> insertMealAbsentDetail(BuildContext context, dynamic data) async {
  dynamic jsonBody = data;
  macaPrint("jsonData: $jsonBody");
  dynamic response = await ApiService().apiCallService(endpoint: PostUrl().insertMealAbsentDetail, method: ApiType().post, body: jsonBody);

  AppFunction().macaApiResponsePrintAndGet(data: response, snackBarView: true, context: context);
  Navigator.of(context).pop();
}

Future<List<AbsentUserData>> getCurrentMonthAbsentData() async {
  dynamic response = await ApiService().apiCallService(endpoint: GetUrl().getCurrentMonthAbsentData, method: ApiType().get);
  final responseData = (AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data") ?? []).map<AbsentUserData>((e) => AbsentUserData.fromJson(e)).toList();

  return responseData;
}
