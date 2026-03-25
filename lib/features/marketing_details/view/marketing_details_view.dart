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
  String yearController = (DateTime.now().year).toString();
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    dynamic response = await ApiService().apiCallService(endpoint: PostUrl().marketingDetails, method: ApiType().post, body: {"selectedYear": yearController});
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.theme,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Monthly marketing",
                    style: TextStyle(color: AppColors.theme, fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(color: AppColors.themeWhite, borderRadius: BorderRadius.circular(20), boxShadow: [
                  BoxShadow(
                    color: AppColors.theme.withOpacity(.1),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ]),
                child: Row(
                  children: [
                    Text(
                      yearController,
                      style: TextStyle(fontSize: 12, color: AppColors.theme),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),

                          // Optional: This limits the picker to a more compact month/year view in some versions
                          initialDatePickerMode: DatePickerMode.year,
                        );

                        if (pickedDate != null) {
                          setState(() {
                            yearController = pickedDate.year.toString();
                          });
                          _fetchData();
                        }
                      },
                      child: Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: AppColors.theme,
                      ),
                    ),
                  ],
                ),
              )
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
                              selectedYear: yearController,
                            ),
                    );
                  },
                ),
        ));
  }
}
