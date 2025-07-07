import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper/helper.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/features/add_electric_bill/pdf/electric_bill_pdf_view.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class RepaintWidget extends StatefulWidget {
  final dynamic expenditureDetails;
  final String? internetBill;
  final String? totalElectricUnits;
  final String? totalElectricBill;
  final List<ActiveUser>? userList;
  final List<UserElectricBillItem>? userFinalList;
  const RepaintWidget({super.key, this.expenditureDetails, this.internetBill, this.totalElectricBill, this.totalElectricUnits, this.userFinalList, this.userList});

  @override
  State<RepaintWidget> createState() => _RepaintWidgetState();
}

class _RepaintWidgetState extends State<RepaintWidget> {
  final GlobalKey previewContainer = GlobalKey();
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
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.theme,
                )),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Invoice",
              style: TextStyle(color: AppColors.theme, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.themeWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 20, left: 20, right: 20),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Offstage(
                offstage: false,
                child: RepaintBoundary(
                  key: previewContainer,
                  child: ElectricBillPdfView(
                    expenditureDetails: widget.expenditureDetails,
                    internetBill: widget.internetBill!,
                    totalElectricBill: widget.totalElectricBill!,
                    totalElectricUnits: widget.totalElectricUnits!,
                    userList: widget.userList!, // fill this
                    userFinalList: widget.userFinalList!, // fill this
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: AppButtonStyles.elevatedButtonStyle(
                  backgroundColor: AppColors.theme,
                ),
                onPressed: () => generatePdfFromWidget(previewContainer),
                child: Text(
                  "Download",
                  style: TextStyle(color: AppColors.themeWhite),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
