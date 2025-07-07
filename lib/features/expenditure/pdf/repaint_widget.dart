import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper/helper.dart';
import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/model/establishment_item.dart';
import 'package:maca/features/expenditure/pdf/expenditure_pdf.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class RepaintWidget extends StatefulWidget {
  final dynamic expenditureDetails;
  final int totalMeal;
  final int totalMember;
  final int totalEstablishment;
  final int totalMarketing;
  final List<EstablishmentItem> establishmentList;
  final List<ExpendBorderItem> userFinalList;

  const RepaintWidget(
      {super.key,
      this.establishmentList = const [],
      this.expenditureDetails,
      this.totalEstablishment = 0,
      this.totalMarketing = 0,
      this.totalMeal = 0,
      this.totalMember = 0,
      this.userFinalList = const []});

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
                  child: ExpenditurePdf(
                    expenditureDetails: widget.expenditureDetails,
                    totalMeal: widget.totalMeal,
                    userFinalList: widget.userFinalList,
                    establishmentList: widget.establishmentList,
                    totalEstablishment: widget.totalEstablishment,
                    totalMarketing: widget.totalMarketing,
                    totalMember: widget.totalMember,

                    // fill this
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
