import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/common/loading_component.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/features/electric_bills/view/electrics_bill_view.dart';
import 'package:maca/features/profile_view/profile_view.dart';
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

    setState(() {
      isLoading = false;
      expenditureDetails = [];
    });
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
                      // CurrentManagerView(
                      //   data: expenditureDetails[0]["user_type_name"],
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // ExpenditureTiles(data: expenditureDetails),
                      // const SizedBox(
                      //   height: 16,
                      // ),

                      const ElectricsBillView(),
                      const SizedBox(
                        height: 16,
                      ),
                      MColumnGraph(data: expenditureDetails),
                    ],
                  )));
  }
}
