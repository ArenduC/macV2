import 'package:maca/env/env.dart';

class PostUrl {
  String borderList = "${Connection().baseUrl}v1/borderlist";
  String userLogin = "${Connection().baseUrl}v1/user_login";
  String marketingStatusUpdate =
      "${Connection().baseUrl}v1/set_marketing_shift";
  String addExpense = "${Connection().baseUrl}v1/add_expense";
  String individualMarketStatus =
      "${Connection().baseUrl}v1/get_individual_marketing_status";
}

class GetUrl {
  String bedList = "${Connection().baseUrl}v1/bed_available";
  String marketList = "${Connection().baseUrl}v1/get_marketing_status";
  String currentExpenditureDetails =
      "${Connection().baseUrl}v1/current_marketing_details";
}
