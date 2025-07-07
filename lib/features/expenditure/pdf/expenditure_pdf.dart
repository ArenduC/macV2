import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/model/establishment_item.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class ExpenditurePdf extends StatefulWidget {
  final dynamic expenditureDetails;
  final int totalMeal;
  final int totalMember;
  final int totalEstablishment;
  final int totalMarketing;
  final List<EstablishmentItem> establishmentList;
  final List<ExpendBorderItem> userFinalList;

  const ExpenditurePdf(
      {super.key,
      this.establishmentList = const [],
      this.expenditureDetails,
      this.totalEstablishment = 0,
      this.totalMarketing = 0,
      this.totalMeal = 0,
      this.totalMember = 0,
      this.userFinalList = const []});

  @override
  State<ExpenditurePdf> createState() => _ExpenditurePdfState();
}

class _ExpenditurePdfState extends State<ExpenditurePdf> {
  @override
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
                decoration: BoxDecoration(color: AppColors.theme, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/APPSVGICON/maca.svg',
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          "Expenditure",
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
                                style: TextStyle(
                                  color: AppColors.themeWhite,
                                  fontSize: 15,
                                )),
                            Text("Manager", style: TextStyle(color: AppColors.themeWhite, fontSize: 10, height: 0))
                          ],
                        ),
                        SizedBox(
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
                                style: TextStyle(
                                  color: AppColors.themeWhite,
                                  fontSize: 15,
                                )),
                            Text("Month",
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
                                  "E${widget.expenditureDetails[0]["user_type_name"][0]}${widget.totalMeal}${formatCustomDate(DateTime.now())["Month"][0]}${formatCustomDate(DateTime.now())["Day"][0]}",
                                  style: TextStyle(
                                    color: AppColors.themeWhite,
                                    fontSize: 15,
                                  )),
                              Text("Invoice",
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
                billItem(data: widget.totalMarketing, unit: "Rs.", label: "Marketing"),
                billItem(data: widget.totalEstablishment, unit: "Rs.", label: "Establishment"),
                billItem(data: widget.totalMeal, unit: "Rs.", label: "Meal"),
                billItem(data: (widget.totalMarketing / widget.totalMeal).toDouble().toStringAsFixed(2), unit: "Rs.", label: "Per Meal")
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          establishmentList(establishmentList: widget.establishmentList, totalMember: widget.totalMember),
          const SizedBox(
            height: 15,
          ),
          borderList(borderList: widget.userFinalList, manager: widget.expenditureDetails[0]["user_type_name"]),
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
              "$unit",
              style: AppTextStyles.header11,
            ),
            Text(
              "$data",
              style: AppTextStyles.cardLabel1,
            ),
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
Widget borderList({List<ExpendBorderItem>? borderList, String? manager}) {
  if (borderList == null || borderList.isEmpty) {
    return const Center(child: Text("No data available"));
  }

  int remaining = 0;
  for (var item in borderList) {
    remaining += item.balance;
  }

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // HEADER
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.theme,
          ),
          padding: const EdgeInsets.all(5),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: Text(
                'Boarder',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Meal',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Deposit',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Marketing',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Meal Exp',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              child: Text(
                'Balance',
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
              color: isEven ? AppColors.themeLite.withOpacity(.1) : AppColors.themeWhite,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        if (item.name == manager)
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(11)), color: AppColors.theme),
                            child: Text(
                              "M",
                              style: TextStyle(fontSize: 10, color: AppColors.themeWhite),
                            ),
                          ),
                        const SizedBox(
                          width: 2,
                        ),
                        if (item.isGestMeal)
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                            decoration: BoxDecoration(color: AppColors.theme.withOpacity(.2), borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "G${item.gestMeal}",
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
                      "${item.mealCount}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${item.deposit}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${item.expenditure}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${item.totalExpend}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      "${item.balance.abs()}",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 10, color: item.balance < 0 ? AppColors.errorColor : AppColors.successColor),
                    ),
                  ),
                  // Add more fields here if needed, e.g. amount
                ],
              ),
            );
          },
        ),
        Divider(
          color: AppColors.theme,
        ),
        Container(
          padding: const EdgeInsets.only(right: 5),
          child: Text(
            "Total: ${remaining.abs()}",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 10, color: remaining < 0 ? AppColors.errorColor : AppColors.successColor),
          ),
        )
      ],
    ),
  );
}

@override
Widget establishmentList({List<EstablishmentItem>? establishmentList, int? totalMember}) {
  if (establishmentList == null || establishmentList.isEmpty) {
    return const Center(child: Text("No data available"));
  }

  double totalAmount = 0.0;

  for (var item in establishmentList) {
    totalAmount += item.itemAmount ?? 0.0;
  }

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // HEADER
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.theme,
          ),
          padding: const EdgeInsets.all(5),
          child: Row(children: [
            Expanded(
              flex: 4,
              child: Text(
                'Establishment item',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.themeWhite),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Amount',
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
          itemCount: establishmentList.length,
          itemBuilder: (context, index) {
            final item = establishmentList[index];

            final bool isEven = index % 2 == 0;

            return Container(
              color: isEven ? AppColors.themeLite.withOpacity(.1) : AppColors.themeWhite,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Text(
                          item.itemName!,
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${item.itemAmount}",
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Divider(
          color: AppColors.theme,
        ),
        Container(
          padding: const EdgeInsets.only(right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Per Head: ${(totalAmount / totalMember!.toDouble()).toStringAsFixed(2)}",
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 10),
              ),
              Text(
                "Total: $totalAmount",
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
