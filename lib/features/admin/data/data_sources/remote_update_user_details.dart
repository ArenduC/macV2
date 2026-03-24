import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

class RemoteUpdateUserDetails {
  Future<void> fetchAllUserDetails() async {
    try {
      final response = await ApiService().apiCallService(
        endpoint: GetUrl().getAllUserDetails,
        method: ApiType().get,
      );

      final marketingDetails = AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data");
      final List<dynamic> list = marketingDetails;
    } catch (e) {
      throw e.toString();
    }
  }
}
