import 'package:maca/connection/api_connection_model.dart';
import 'package:maca/env/env.dart';

class PostUrl {
  String borderList = "${Connection().baseUrl}v1/borderlist";
  String userLogin = PostApiConnectionModel().login;
  String userRegistration = "${Connection().prodUrl}v1/user_registration";
  String marketingStatusUpdate = "${Connection().prodUrl}v1/set_marketing_shift";
  String addExpense = "${Connection().prodUrl}v1/add_expense";
  String individualMarketStatus = "${Connection().prodUrl}v1/get_individual_marketing_status";
  String electricBillCreate = "${Connection().prodUrl}v1/electric_bill_create";
  String addMeterReading = "${Connection().prodUrl}v1/add_meter_reading";
  String insertMealAbsentDetail = "${Connection().prodUrl}v1/insert_meal_absent_detail";
}

class GetUrl {
  String bedList = "${Connection().prodUrl}v1/bed_availability";
  String marketList = "${Connection().prodUrl}v1/get_marketing_status";
  String currentExpenditureDetails = "${Connection().prodUrl}v1/current_marketing_details";
  String marketingDetails = "${Connection().prodUrl}v1/marketing_details";
  String getAllElectricBills = "${Connection().prodUrl}v1/get_all_electric_bills";
  String activeUserList = "${Connection().prodUrl}v1/active_user_list";
  String activeMeterList = "${Connection().prodUrl}v1/active_meter_list";
  String getMonthlyMeterReadings = "${Connection().prodUrl}v1/get_monthly_meter_readings";
  String getCurrentMonthAbsentData = "${Connection().prodUrl}v1/get_current_month_absent_data";
}
