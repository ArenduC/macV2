import 'package:flutter/material.dart';
import 'package:maca/features/marketing_details/marketing_details_helper.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MarketingListWidget extends StatefulWidget {
  final dynamic marketingDetails;
  final dynamic monthData;
  const MarketingListWidget({super.key, required this.marketingDetails, required this.monthData});

  @override
  State<MarketingListWidget> createState() => _MarketingListWidgetState();
}

class _MarketingListWidgetState extends State<MarketingListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        boxShadow: [AppBoxShadow.defaultBoxShadow],
        color: AppColors.themeWhite,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ExpansionTile(
        dense: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        tilePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.monthData),
              Text("₹ ${totalAmountCounter(data: widget.marketingDetails.data).toString()}", style: AppTextStyles.cardHeaderLabelStyle),
            ],
          ),
        ),
        children: <Widget>[
          SizedBox(height: 1, child: Container(color: AppColors.themeLite)),
          Column(
            children: List.generate(
              widget.marketingDetails.data.length,
              (innerIndex) {
                final userData = widget.marketingDetails.data[innerIndex];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      caseConverter(data: userData.user),
                      style: AppTextStyles.header10,
                    ),
                    Text((userData.totalAmount).toString()),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
