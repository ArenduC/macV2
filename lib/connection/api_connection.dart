const basUrl = "http://192.168.2.6:3000/maca/";

class PostUrl {
  String borderList = "${basUrl}v1/borderlist";
  String userLogin = "${basUrl}v1/user_login";
  String marketingStatusUpdate = "${basUrl}v1/set_marketing_shift";
  String addExpense = "${basUrl}v1/add_expense";
  String individualMarketStatus = "${basUrl}v1/get_individual_marketing_status";
}

class GetUrl {
  String bedList = "${basUrl}v1/bed_available";
  String marketList = "${basUrl}v1/get_marketing_status";
}
