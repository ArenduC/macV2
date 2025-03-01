import 'package:maca/env/env.dart';

class GetApiConnectionModel {
  String getBorderList = "v1/borderlist";
  String getMarketingStatus = "v1/marketing_status";
  String getExpenseList = "v1/expense_list";
  String getIndividualMarketStatus = "v1/get_individual_marketing_status";
}

class PostApiConnectionModel {
  String borderList = "v1/borderlist";
  String login = "${Connection().baseUrl}v1/user_login";
  String marketingStatusUpdate = "v1/set_marketing_shift";
  String addExpense = "v1/add_expense";
  String individualMarketStatus = "v1/get_individual_marketing_status";
}
