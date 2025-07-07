import 'package:flutter/material.dart';
import 'package:maca/features/electric_bills/electric_bills_helper.dart';
import 'package:maca/features/electric_bills/electric_bills_model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class ElectricsBillView extends StatefulWidget {
  const ElectricsBillView({super.key});

  @override
  State<ElectricsBillView> createState() => _ElectricsBillViewState();
}

class _ElectricsBillViewState extends State<ElectricsBillView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ElectricBillModel>>(
      future: getMarketingDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data found');
        }

        final bills = snapshot.data![0];
        final previousBill = snapshot.data![1];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                boxShadow: const [AppBoxShadow.defaultBoxShadow],
                color: AppColors.themeWhite,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       children: [Text("₹"), Text("470")],
                  //     ),
                  //     Row(
                  //       children: [Text("Electric Bill"), Icon(Icons.gas_meter_rounded)],
                  //     ),
                  //     Row(
                  //       children: [Text("Previous | 320"), Icon(Icons.arrow_circle_up_sharp)],
                  //     )
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "₹",
                                style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w200),
                              ),
                              Text(
                                "${bills.electricBill}",
                                style: AppTextStyles.cardLabel1.copyWith(height: 0),
                              )
                            ],
                          ),
                          Text(
                            "Total Bill",
                            style: AppTextStyles.header11,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${bills.electricUnit}",
                                style: AppTextStyles.header18.copyWith(height: 0),
                              ),
                              Icon(
                                Icons.arrow_circle_up_sharp,
                                size: 10,
                                color: AppColors.theme,
                              )
                            ],
                          ),
                          Text("Unit", style: AppTextStyles.header11),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                "₹",
                                style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w200),
                              ),
                              Text(
                                "${previousBill.electricBill}",
                                style: AppTextStyles.header18.copyWith(height: 0),
                              )
                            ],
                          ),
                          Text("Previous", style: AppTextStyles.header11)
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            " ${previousBill.electricUnit}",
                            style: AppTextStyles.header18.copyWith(height: 0),
                          ),
                          Row(
                            children: [Text("Unit", style: AppTextStyles.header11)],
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                "₹",
                                style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w200),
                              ),
                              Text(
                                "${bills.internetBill}",
                                style: AppTextStyles.header18.copyWith(height: 0),
                              )
                            ],
                          ),
                          Text("Internet", style: AppTextStyles.header11)
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${formatCustomDate(bills.createdDate)["Day"]} ${formatCustomDate(bills.createdDate)["Month"]}",
                            style: AppTextStyles.header16.copyWith(height: 0),
                          ),
                          Row(
                            children: [Text("Created Date", style: AppTextStyles.header11)],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
