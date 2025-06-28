import 'package:flutter/material.dart';
import 'package:maca/common/default_page.dart';
import 'package:maca/common/loading_component.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/marketing_details/marketing_details_helper.dart';
import 'package:maca/features/marketing_details/marketing_details_model.dart';
import 'package:maca/features/marketing_details/view/marketing_list_widget.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MarketingDetailsView extends StatefulWidget {
  const MarketingDetailsView({super.key});

  @override
  State<MarketingDetailsView> createState() => _MarketingDetailsViewState();
}

class _MarketingDetailsViewState extends State<MarketingDetailsView> {
  List<MonthData>? marketingDetails;
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    dynamic response = await ApiService().apiCallService(
      endpoint: GetUrl().marketingDetails,
      method: ApiType().get,
    );
    setState(() {
      marketingDetails = convertAllMarketingDetailsToIndividualModels(inputData: AppFunction().macaApiResponsePrintAndGet(data: response, extractData: "data"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.themeWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.theme,
                  )),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Monthly marketing",
                style: TextStyle(color: AppColors.theme, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: AppColors.themeWhite,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: marketingDetails == null || marketingDetails!.isEmpty
              ? const LoadingComponent()
              : ListView.builder(
                  itemCount: marketingDetails!.length,
                  itemBuilder: (context, index) {
                    final monthData = marketingDetails![index];
                    return ListTile(
                      subtitle: monthData.data.isEmpty
                          ? const DefaultPage()
                          : MarketingListWidget(
                              marketingDetails: monthData,
                              monthData: monthData.month,
                            ),
                    );
                  },
                ),
        ));
  }
}
