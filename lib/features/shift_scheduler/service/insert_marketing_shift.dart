import 'dart:convert';

import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/shift_scheduler/model/shift_schedule.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

Future<Object> insertMarketingShifts(
  List<ShiftAssignment> shifts,
  String createdId,
) async {
  final body = buildMarketingShiftRequest(shifts, createdId);

  macaPrint(body, "data");

  final response = await ApiService().apiCallService(
    endpoint: PostUrl().insertMarketingShifts,
    method: ApiType().post,
    body: body,
  );

  final Map<String, dynamic> responseJson = response is String ? jsonDecode(response as String) : jsonDecode(response.body);

  return ApiResponse.fromJson(
    responseJson,
    (data) => data as List<dynamic>,
  );
}
