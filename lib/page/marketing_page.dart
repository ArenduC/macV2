import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/common/loading_component.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/provider/notification_provider.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:provider/provider.dart';

class MarketingPage extends StatefulWidget {
  const MarketingPage({super.key});

  @override
  State<MarketingPage> createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage> {
  //for text controller
  dynamic marketingList = [];
  dynamic loginData;
  dynamic userMarketingDetails;

  @override
  void initState() {
    super.initState();
    getDataFromLocalStorage();
    getMarketingDetails();
    getProviderController();
  }

  //It's for provider controller
  getProviderController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<WidgetUpdate>(context, listen: false);
      provider.addListener(() {
        getMarketingDetails(); // Call your function when provider updates
      });
    });
  }

  //for fetching local stor data
  Future getDataFromLocalStorage() async {
    loginData = await getLocalStorageData("loginDetails");
    macaPrint(loginData);
  }

  // this method for getting date from user input

  Future<dynamic> getMarketingDetails() async {
    dynamic response = await ApiService().apiCallService(endpoint: GetUrl().marketList, method: ApiType().get);

    setState(() {
      marketingList = AppFunction().macaApiResponsePrintAndGet(data: response)["data"];
    });
    for (var data in marketingList) {
      if (data["user_id"] == loginData[0]["user_id"]) {
        setState(() {
          userMarketingDetails = data;
        });
        break; // Stop the loop after finding the match
      }
    }
    LocalStore().setStore(ListOfStoreKey.inUsMrDetails, userMarketingDetails);
    macaPrint(userMarketingDetails, "userMarketingDetails");
    macaPrint(marketingList, "marketingList");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WidgetUpdate>(builder: (context, countProvider, _) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: AppColors.theme,
          title: const Text('Marketing', style: TextStyle(color: AppColors.themeWhite)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: marketingList == null || marketingList.isEmpty
              ? const LoadingComponent()
              : Column(children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: marketingList.length,
                      itemBuilder: (context, index) {
                        final user = marketingList[index];
                        return Container(
                            width: double.infinity, // Make it take full width
                            alignment: Alignment.centerLeft, // Align text to the left
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                            child: marketingStatusView(user));
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 4,
                      ),
                    ),
                  ),
                ]),
        ),
      );
    });
  }
}

@override
Widget marketingStatusView(dynamic data) {
  bool status = data["status"] == 3 ? false : true;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(boxShadow: [AppBoxShadow.defaultBoxShadow], color: AppColors.themeWhite, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 10,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            color: getMarketStatusColor(data["status"]),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 18, top: 8, right: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/APPSVGICON/profileIcon.svg',
                          width: 40,
                          height: 40,
                          colorFilter: status ? const ColorFilter.mode(AppColors.themeLite, BlendMode.dst) : const ColorFilter.mode(Color.fromARGB(108, 217, 217, 217), BlendMode.dstIn),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["marketing_user"],
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: status ? AppColors.theme : AppColors.completed,
                              ),
                            ),
                            Text(
                              getMarketStatus(data["status"]),
                              style: TextStyle(fontSize: 10, color: status ? AppColors.themeLite : AppColors.completed),
                            )
                          ],
                        ),
                      ],
                    ),
                    shiftView({
                      "startDate": data["startDate"],
                      "endDate": data["endDate"],
                      "startShift": data["startShift"],
                      "endShift": data["endShift"],
                      "active": status,
                    })
                  ],
                ))
          ],
        ),
      ]),
    ),
  );
}

@override
Widget shiftView(dynamic data) {
  bool status = data["active"];
  return Row(
    children: [
      if (data["startDate"] == null)
        Container(
            alignment: Alignment.center,
            height: 50,
            width: 80,
            decoration: const BoxDecoration(
              color: AppColors.themeWhite,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            padding: const EdgeInsets.all(2),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_calendar,
                  size: 15,
                  color: AppColors.themeLite,
                ),
                Text("Not selected", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.themeLite))
              ],
            )),
      if (data["startDate"] != null)
        Row(
          children: [
            shiftCard(data["startDate"], data["startShift"] == 1 ? true : false, status, data["startShift"]),
            const SizedBox(
              width: 8,
            ),
            shiftCard(data["endDate"], data["endShift"] == 1 ? true : false, status, data["endShift"])
          ],
        )
    ],
  );
}

@override
Widget shiftCard(dynamic data, dynamic shiftOpen, status, dynamic value) {
  macaPrint(value, "shiftOpen");
  return Container(
    height: 50,
    width: 80,
    decoration: BoxDecoration(
        color: shiftOpen
            ? status
                ? AppColors.themeLite
                : AppColors.completed
            : AppColors.themeWhite,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(
            color: shiftOpen
                ? AppColors.themeWhite
                : status
                    ? AppColors.themeLite
                    : AppColors.completed,
            width: shiftOpen ? 0 : 1)),
    padding: const EdgeInsets.all(2),
    child: Stack(children: [
      Positioned(
          top: 2,
          right: 2,
          child: Icon(
            shiftOpen ? Icons.nights_stay : Icons.sunny,
            size: 15,
            color: shiftOpen
                ? AppColors.themeWhite
                : status
                    ? AppColors.themeLite
                    : AppColors.completed,
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text((formatCustomDate(data)["Day"]),
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: shiftOpen
                          ? AppColors.themeWhite
                          : status
                              ? AppColors.themeLite
                              : AppColors.completed)),
              const SizedBox(
                width: 5,
              ),
              Text(
                (formatCustomDate(data)["Month"]),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: shiftOpen
                        ? AppColors.themeWhite
                        : status
                            ? AppColors.themeLite
                            : AppColors.completed),
              )
            ],
          ),
        ],
      ),
    ]),
  );
}
