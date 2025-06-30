import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/marketing_details/marketing_details_helper.dart';
import 'package:maca/features/marketing_details/marketing_details_model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

Future<MonthData> individualMarketing() async {
  dynamic response = await ApiService().apiCallService(
    endpoint: GetUrl().marketingDetails,
    method: ApiType().get,
  );

  var marketingDetails = convertAllMarketingDetailsToIndividualModels(inputData: AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data"));

  macaPrint("marketingDetails: ${marketingDetails[0]}");

  final userTotal = marketingDetails[0]
      .data
      .firstWhere(
        (m) => m.userId == 23,
        orElse: () => IndividualMarketingDetails(userId: 0, user: '', totalAmount: 0.0),
      )
      .totalAmount;

  macaPrint("userTotal: $userTotal");
  return marketingDetails[0];
}

double getIndividualExpenditure(MonthData data, int userId) {
  final userTotal = data.data
      .firstWhere(
        (m) => m.userId == userId,
        orElse: () => IndividualMarketingDetails(userId: 0, user: '', totalAmount: 0.0),
      )
      .totalAmount;

  return userTotal;
}
