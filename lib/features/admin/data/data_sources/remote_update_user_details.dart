import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/admin/data/models/update_user_details_parameter.dart';
import 'package:maca/features/admin/data/models/update_user_details_response.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';

class RemoteUpdateUserDetails {
  Future<UpdateUserDetailsResponse> updateUserStatus(UpdateUserDetailsParameter body) async {
    try {
      final response = await ApiService().apiCallService(endpoint: PostUrl().updateUserStatus, method: ApiType().post, body: body);

      final marketingDetails = AppFunction().macaApiResponsePrintAndGet(
        data: response,
      );
      print("response $marketingDetails");

      return UpdateUserDetailsResponse.fromJson(marketingDetails);
    } catch (e) {
      throw e.toString();
    }
  }
}
