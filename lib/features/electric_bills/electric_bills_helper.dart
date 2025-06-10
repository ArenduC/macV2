import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/electric_bills/electric_bills_model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

Future<List<ElectricBillModel>> getMarketingDetails() async {
  dynamic response = await ApiService().apiCallService(endpoint: GetUrl().getAllElectricBills, method: ApiType().get);

  final bills = (AppFunction().macaApiResponsePrintAndGet(data: response)["data"] as List).map((e) => ElectricBillModel.fromJson(e)).toList();

  return bills;
}
