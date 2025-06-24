import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/common/loading_component.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/features/electric_bills/view/electrics_bill_view.dart';
import 'package:maca/features/profile_view/profile_view.dart';
import 'package:maca/features/rule_base_attendance/controller/meal_sift.dart';
import 'package:maca/features/rule_base_attendance/model/mealsInformation.dart';
import 'package:maca/features/rule_base_attendance/service/api_service.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/package/m_column_graph.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:maca/widget/app_common_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  dynamic expenditureDetails = [];
  List<AbsentUserData> absentUserData = [];
  dynamic mealCountDetails;
  bool isLoading = true;

  @override
  void initState() {
    initialization();
    borderList();
    getLoginDetails();
    super.initState();
  }

  void initialization() {
    setState(() {
      isLoading = true;
    });
  }

  Future<void> borderList() async {
    dynamic response = await ApiService().apiCallService(endpoint: GetUrl().currentExpenditureDetails, method: "GET");
    absentUserData = await getCurrentMonthAbsentData();

    setState(() {
      expenditureDetails = AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data");
      LocalStore().setStore(ListOfStoreKey.expenditureDetails, expenditureDetails);
      macaPrint("expenditure$expenditureDetails");
      getMealDetails();
    });
  }

  getMealDetails() {
    macaPrint("AbsentUserDetailsListData$absentUserData");

    mealCountDetails = calculateTotalMeals(daysInMonth: 30, totalUsers: 10, absentData: absentUserData);

    macaPrint("meal absent details $mealCountDetails");
    isLoading = false;
  }

  getLoginDetails() async {
    dynamic loginDetails;
    loginDetails = await LocalStore().getStore(ListOfStoreKey.loginDetails);
    macaPrint(loginDetails);
  }

  void _gotoDetailsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: Hero(
                transitionOnUserGestures: true,
                flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                      color: Colors.transparent,
                      child: toHeroContext.widget,
                    ),
                tag: 'hero-rectangle',
                child: ProfileView(
                  fullView: true,
                )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.themeWhite,
        appBar: AppBar(
          backgroundColor: AppColors.theme,
          surfaceTintColor: AppColors.theme,
          automaticallyImplyLeading: false,
          title: SvgPicture.asset(
            "assets/APPSVGICON/maca.svg",
            width: 60,
          ),
          actions: <Widget>[
            SizedBox(
              width: 50,
              height: 50, // Adjust the width as needed
              child: GestureDetector(
                onTap: () {
                  _gotoDetailsPage(context);
                },
                child: Hero(
                  tag: 'profile-view',
                  child: ProfileView(),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? const LoadingComponent()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11)), color: Color.fromARGB(38, 40, 46, 137)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.account_circle_rounded,
                              color: AppColors.theme,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${formatCustomDate(DateTime.now())["Day"]} ${formatCustomDate(DateTime.now())["Month"]}",
                                  style: const TextStyle(color: AppColors.theme, fontWeight: FontWeight.w500, fontSize: 12),
                                ),
                                Text(
                                  "Morning meal ${mealCountDetails["currentDayMealCount"]["day"]} | Evening meal ${mealCountDetails["currentDayMealCount"]["night"]} ",
                                  style: const TextStyle(color: AppColors.theme, fontSize: 10),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      CurrentManagerView(
                        data: expenditureDetails[0]["user_type_name"],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ExpenditureTiles(data: expenditureDetails),
                      const SizedBox(
                        height: 16,
                      ),
                      const ElectricsBillView(),
                      const SizedBox(
                        height: 16,
                      ),
                      MColumnGraph(data: expenditureDetails),
                    ],
                  )));
  }
}
