import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class ElectricBillPdfView extends StatefulWidget {
  final dynamic expenditureDetails;
  final String internetBill;
  final String totalElectricUnits;
  final String totalElectricBill;
  final List<ActiveUser> userList;
  final List<UserElectricBillItem> userFinalList;
  const ElectricBillPdfView({
    super.key,
    required this.expenditureDetails,
    required this.internetBill,
    required this.totalElectricBill,
    required this.totalElectricUnits,
    required this.userList,
    required this.userFinalList,
  });

  @override
  State<ElectricBillPdfView> createState() => _ElectricBillPdfViewState();
}

class _ElectricBillPdfViewState extends State<ElectricBillPdfView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: AppColors.theme, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/APPSVGICON/maca.svg',
                          width: 30,
                          height: 30,
                        ),
                        const Text(
                          "Electric Bill",
                          style: TextStyle(color: AppColors.themeWhite, fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.expenditureDetails[0]["user_type_name"],
                                style: const TextStyle(
                                  color: AppColors.themeWhite,
                                  fontSize: 15,
                                )),
                            const Text("Manager", style: TextStyle(color: AppColors.themeWhite, fontSize: 10, height: 0))
                          ],
                        ),
                        const SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Belghoria",
                                  style: TextStyle(
                                    color: AppColors.themeWhite,
                                    fontSize: 15,
                                  )),
                              Text("Place", style: TextStyle(color: AppColors.themeWhite, fontSize: 10, height: -0))
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${formatCustomDate(DateTime.now())["Month"]} ${formatCustomDate(DateTime.now())["Year"]}",
                                style: const TextStyle(
                                  color: AppColors.themeWhite,
                                  fontSize: 15,
                                )),
                            const Text("Month",
                                style: TextStyle(
                                  color: AppColors.themeWhite,
                                  fontSize: 10,
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "E${widget.expenditureDetails[0]["user_type_name"][0]}${widget.internetBill[0]}${widget.totalElectricBill[0]}${formatCustomDate(DateTime.now())["Month"][0]}${formatCustomDate(DateTime.now())["Day"][0]}",
                                  style: const TextStyle(
                                    color: AppColors.themeWhite,
                                    fontSize: 15,
                                  )),
                              const Text("Invoice",
                                  style: TextStyle(
                                    color: AppColors.themeWhite,
                                    fontSize: 10,
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                billItem(data: widget.totalElectricBill, unit: "Rs.", label: "Amount"),
                billItem(data: widget.totalElectricUnits, unit: "kWh", label: "Unit"),
                billItem(data: widget.internetBill, unit: "Rs.", label: "Internet")
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          borderList(borderList: widget.userFinalList),
        ],
      ),
    );
  }
}

@override
Widget billItem({data, label, unit}) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              "$data",
              style: AppTextStyles.cardLabel1,
            ),
            Text(
              "$unit",
              style: AppTextStyles.header11,
            )
          ],
        ),
        Text(
          "$label",
          style: AppTextStyles.header11B.copyWith(height: -.2),
        )
      ],
    ),
  );
}

@override
Widget borderList({List<UserElectricBillItem>? borderList}) {
  if (borderList == null || borderList.isEmpty) {
    return const Center(child: Text("No data available"));
  }

  return SingleChildScrollView(
    child: Column(
      children: [
        // HEADER
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.theme,
          ),
          padding: const EdgeInsets.all(5),
          child: const Row(children: [
            Expanded(
              flex: 4,
              child: Text(
                'Border List',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Internet',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'GE',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              child: Text(
                'Total',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
          ]),
        ),

        // LIST
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // prevent nested scrolling
          itemCount: borderList.length,
          itemBuilder: (context, index) {
            final item = borderList[index];

            final bool isEven = index % 2 == 0;

            return Container(
              color: isEven ? AppColors.theme.withOpacity(.1) : AppColors.themeWhite,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Text(
                          item.userName,
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        if (item.meterName != "")
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                            decoration: BoxDecoration(color: AppColors.theme.withOpacity(.2), borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "M${item.meterName} | ${item.unit} | ${item.mElectricBill}",
                                  style: const TextStyle(fontSize: 7),
                                )
                              ],
                            ),
                          ),
                        if (item.oExpend != 0)
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                            decoration: BoxDecoration(color: AppColors.ongoing.withOpacity(.4), borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "A${item.oExpend}",
                                  style: const TextStyle(fontSize: 7),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${item.internet}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${item.gElectricBill}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      "${item.total}",
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  // Add more fields here if needed, e.g. amount
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
