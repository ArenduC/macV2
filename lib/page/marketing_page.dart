import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MarketingPage extends StatefulWidget {
  const MarketingPage({super.key});

  @override
  State<MarketingPage> createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage> {
  //for text controller
  dynamic marketingList = [];
  dynamic loginData;

  @override
  void initState() {
    super.initState();
    getDataFromLocalStorage();
    getMarketingDetails();
  }

  //for fetching local stor data
  Future getDataFromLocalStorage() async {
    loginData = await getLocalStorageData("loginDetails");
    macaPrint(loginData);
  }

  // this method for getting date from user input

  Future<dynamic> getMarketingDetails() async {
    dynamic response = await ApiService()
        .apiCallService(endpoint: GetUrl().marketList, method: ApiType().get);

    setState(() {
      marketingList =
          AppFunction().macaApiResponsePrintAndGet(response)["data"];
    });
    macaPrint(marketingList, "marketingList");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Marketing'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(children: [
          Expanded(
            child: ListView.separated(
              itemCount: marketingList.length,
              itemBuilder: (context, index) {
                final user = marketingList[index];
                return Container(
                    width: double.infinity, // Make it take full width
                    alignment: Alignment.centerLeft, // Align text to the left
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: marketingStatusView(user));
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.transparent,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

@override
Widget marketingStatusView(dynamic data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
          boxShadow: [AppBoxShadow.defaultBoxShadow],
          color: AppColors.themeWhite,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 10,
          width: 35,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: AppColors.themeLite,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(
                    left: 18, top: 8, right: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/APPSVGICON/profileIcon.svg',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["marketing_user"],
                              style: AppTextStyles.header10,
                            ),
                            Text(
                              getMarketStatus(data["status"]),
                              style:
                                  const TextStyle(color: AppColors.themeLite),
                            )
                          ],
                        ),
                      ],
                    ),
                    shiftView({
                      "startDate": data["startDate"],
                      "endDate": data["endDate"]
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
                ),
                Text("Not selected",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ))
              ],
            )),
      if (data["startDate"] != null)
        Row(
          children: [
            shiftCard(data["startDate"], true),
            const SizedBox(
              width: 8,
            ),
            shiftCard(data["endDate"], false)
          ],
        )
    ],
  );
}

@override
Widget shiftCard(dynamic data, dynamic shiftOpen) {
  return Container(
    height: 50,
    width: 80,
    decoration: BoxDecoration(
        color: shiftOpen ? AppColors.themeLite : AppColors.themeWhite,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(
            color: shiftOpen ? AppColors.themeWhite : AppColors.themeLite,
            width: shiftOpen ? 0 : 2)),
    padding: const EdgeInsets.all(2),
    child: Stack(children: [
      Positioned(
          top: 2,
          right: 2,
          child: Icon(
            shiftOpen ? Icons.nights_stay : Icons.sunny,
            size: 15,
            color: shiftOpen ? AppColors.themeWhite : AppColors.themeLite,
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
                          : AppColors.themeLite)),
              const SizedBox(
                width: 5,
              ),
              Text(
                (formatCustomDate(data)["Month"]),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color:
                        shiftOpen ? AppColors.themeWhite : AppColors.themeLite),
              )
            ],
          ),
        ],
      ),
    ]),
  );
}
