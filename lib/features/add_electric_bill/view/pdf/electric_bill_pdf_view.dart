import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/features/add_electric_bill/model.dart';
import 'package:maca/styles/colors/app_colors.dart';

class ElectricBillPdfView extends StatefulWidget {
  final String internetBill;
  final String totalElectricUnits;
  final String totalElectricBill;
  final List<ActiveUser> userList;
  final List<UserElectricBillItem> userFinalList;
  const ElectricBillPdfView({
    super.key,
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
      color: Colors.white,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: AppColors.theme),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sougata Samanta",
                                style: TextStyle(
                                  color: AppColors.themeWhite,
                                  fontSize: 15,
                                )),
                            Text("Manager",
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
                              Text("Belghoria",
                                  style: TextStyle(
                                    color: AppColors.themeWhite,
                                    fontSize: 15,
                                  )),
                              Text("Place",
                                  style: TextStyle(
                                    color: AppColors.themeWhite,
                                    fontSize: 10,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("January, 2025",
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
                              Text("EJS28520",
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

          const SizedBox(height: 16),

          // 🔹 Company Info
          Text('Your Company Name'),
          Text('123 Main Street'),
          Text('City, Country'),
          const SizedBox(height: 16),

          // 🔹 Invoice Details
          Text('Invoice Number: INV-001'),
          Text('Date: 22 June 2025'),
          const SizedBox(height: 16),

          // 🔹 Customer Info
          Text('Billed To:'),
          Text('Customer Name'),
          Text('Customer Address'),
          const SizedBox(height: 24),

          // 🔹 Table Header
          Row(
            children: const [
              Expanded(child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('Rate', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          const Divider(),

          // 🔹 Table Data
          Row(
            children: const [
              Expanded(child: Text('Electricity')),
              Expanded(child: Text('150')),
              Expanded(child: Text('₹10')),
              Expanded(child: Text('₹1500')),
            ],
          ),
          Row(
            children: const [
              Expanded(child: Text('Internet')),
              Expanded(child: Text('1')),
              Expanded(child: Text('₹500')),
              Expanded(child: Text('₹500')),
            ],
          ),
          const Divider(),

          // 🔹 Total
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total: ₹2000',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
