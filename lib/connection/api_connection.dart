import 'package:maca/connection/api_connection_model.dart';
import 'package:maca/env/env.dart';

class PostUrl {
  String borderList = "${Connection().baseUrl}v1/borderlist";
  String userLogin = PostApiConnectionModel().login;
  String userRegistration = "${Connection().prodUrl}v1/user_registration";
  String marketingStatusUpdate = "${Connection().prodUrl}v1/set_marketing_shift";
  String addExpense = "${Connection().prodUrl}v1/add_expense";
  String individualMarketStatus = "${Connection().prodUrl}v1/get_individual_marketing_status";
}

class GetUrl {
  String bedList = "${Connection().prodUrl}v1/bed_availability";
  String marketList = "${Connection().prodUrl}v1/get_marketing_status";
  String currentExpenditureDetails = "${Connection().prodUrl}v1/current_marketing_details";
  String marketingDetails = "${Connection().prodUrl}v1/marketing_details";
}
