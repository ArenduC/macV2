import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/features/marketing_details/marketing_details_helper.dart';
import 'package:maca/features/marketing_details/marketing_details_model.dart';
import 'package:maca/features/marketing_details/view/marketing_details_view.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

//this is for API success screen view
class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle,
          size: 50,
          color: AppColors.themeLite,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Successfully item added",
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.theme),
        )
      ],
    );
  }
}

//this for switch

class SwitchView extends StatefulWidget {
  const SwitchView({super.key});

  @override
  State<SwitchView> createState() => _SwitchViewState();
}

class _SwitchViewState extends State<SwitchView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CurrentManagerView extends StatefulWidget {
  final dynamic data;
  const CurrentManagerView({super.key, required this.data});

  @override
  State<CurrentManagerView> createState() => _CurrentManagerViewState();
}

class _CurrentManagerViewState extends State<CurrentManagerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(boxShadow: const [AppBoxShadow.defaultBoxShadow], color: AppColors.themeWhite, borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Stack(children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  color: AppColors.themeGray,
                ),
                child: Text(
                  formatCustomDate((DateTime.now()).toString())["Month"],
                  style: AppTextStyles.cardPillTextStyle,
                ),
              )),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Manager",
                          style: AppTextStyles.cardHeaderLabelStyle.copyWith(height: 0),
                        ),
                        Text(
                          widget.data,
                          style: AppTextStyles.cardHeader2LabelStyle,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ]));
  }
}

class ExpenditureTiles extends StatefulWidget {
  final dynamic data;
  const ExpenditureTiles({super.key, this.data});

  @override
  State<ExpenditureTiles> createState() => _ExpenditureTilesState();
}

class _ExpenditureTilesState extends State<ExpenditureTiles> {
  List<MonthlyData> individualList = [];
  dynamic expenditure = [];
  @override
  void initState() {
    initialization();
    setIndividualList();
    super.initState();
  }

  void initialization() {
    setState(() {
      expenditure = widget.data[0];
      macaPrint(widget.data, "expenditure");
    });
  }

  setIndividualList() async {
    var data = await getMonthlyIndividualMarketingList();
    setState(() {
      individualList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MarketingDetailsView(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  // Add some spacing around containers
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    boxShadow: const [AppBoxShadow.defaultBoxShadow],
                    color: AppColors.themeWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 1, color: AppColors.theme),
                            ),
                            child: Icon(
                              Icons.supervisor_account_rounded,
                              color: AppColors.theme,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "₹${expenditure["overall_current_month_total"]}",
                                style: AppTextStyles.cardLabel1.copyWith(height: 0),
                              ),
                              Text(
                                "Expenditure",
                                style: AppTextStyles.header11,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  MonthlyData? matchedMonth = individualList.where((monthData) => monthData.month == formatCustomDate(DateTime.now())["Month"]).cast<MonthlyData?>().firstOrNull;
                  List<ItemData>? individualMarketing = [];
                  if (matchedMonth != null) {
                    final matchedUsers = matchedMonth.userData.where((user) => user.userId == expenditure["user_id"]).toList();

                    for (var user in matchedUsers) {
                      individualMarketing.addAll(user.data);
                    }
                  }

                  showBedSelectionModal(context, 6, individualMarketing: individualMarketing);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  padding: const EdgeInsets.all(8), // Add some spacing around containers
                  decoration: BoxDecoration(
                    boxShadow: const [AppBoxShadow.defaultBoxShadow],
                    color: AppColors.themeWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(width: 1, color: AppColors.theme)),
                            child: Icon(Icons.person, color: AppColors.theme),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "₹${expenditure['current_month_total']}",
                                style: AppTextStyles.cardLabel1.copyWith(height: 0),
                              ),
                              Text(
                                expenditure["marketing_user"],
                                style: AppTextStyles.header11,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
