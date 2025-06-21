import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper.dart';
import 'package:maca/features/add_electric_bill/view/pdf/electric_bill_pdf_view.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class RepaintWidget extends StatefulWidget {
  const RepaintWidget({super.key});

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
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.theme,
                )),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Invoice",
              style: TextStyle(color: AppColors.theme, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.themeWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
            children: [
              Offstage(
                offstage: false,
                child: RepaintBoundary(
                  key: previewContainer,
                  child: const ElectricBillPdfView(
                    internetBill: "500",
                    totalElectricBill: "2000",
                    totalElectricUnits: "450",
                    userList: [], // fill this
                    userFinalList: [], // fill this
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
                child: const Text(
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
