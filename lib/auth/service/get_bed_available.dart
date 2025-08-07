import 'package:maca/auth/model/user_bed.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

Future<dynamic> getBedAvailable() async {
  List<UserBed> occupiedBedList;
  dynamic response = await ApiService().apiCallService(endpoint: GetUrl().bedList, method: "GET");
  occupiedBedList = AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data").map<UserBed>((e) => UserBed.fromJson(e)).toList();
  var availableBet = AppFunction().createBedStatusList(occupiedBedList, Appdata().allBeds);

  return availableBet;
}
