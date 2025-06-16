import 'package:flutter/material.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/add_electric_bill/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

Future<dynamic> electricBillCreateUpdate(BuildContext context, dynamic data) async {
  var loginData = await getLocalStorageData("loginDetails");
  var userId = {"p_managerId": loginData[0]["user_id"]};
  dynamic jsonBody = {...userId, ...data};
  macaPrint("jsonData: $jsonBody");
  dynamic response = await ApiService().apiCallService(endpoint: PostUrl().electricBillCreate, method: ApiType().post, body: jsonBody);
  AppFunction().macaApiResponsePrintAndGet(data: response, snackBarView: true, context: context);
}

Future<List<ActiveUser>> getActiveUserList() async {
  dynamic response = await ApiService().apiCallService(endpoint: GetUrl().activeUserList, method: ApiType().get);
  final responseData = AppFunction().macaApiResponsePrintAndGet(data: response)["data"] as List<dynamic>;
  final bills = responseData.reversed.map((e) => ActiveUser.fromJson(e)).toList();
  return bills;
}

bool isAnyFieldEmpty(dynamic data) {
  bool isEnable = data.values.any((value) => value == null || value.toString().trim().isEmpty || value == 0);

  return !isEnable;
}
