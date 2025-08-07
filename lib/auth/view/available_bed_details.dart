import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:path/path.dart';

@override
Widget availableBedDetails(
  dynamic bedNo,
  dynamic bedNumbers,
  Function(
    dynamic title,
    Color indicatorColor,
  ) circularIndicator,
  Function(
    dynamic selectedBedNo,
  ) bedSelectHandle,
) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    alignment: Alignment.center,
    width: double.infinity,
    height: (MediaQuery.of(context as BuildContext).size.height - 64) / 3,
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context as BuildContext);
          },
          child: Container(
            height: 5,
            width: MediaQuery.of(context as BuildContext).size.width * 0.2,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(color: AppColors.textHint, borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/APPSVGICON/bed.svg',
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Bed available",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.theme),
                  )
                ],
              ),
              Row(
                children: [
                  circularIndicator("Idle", AppColors.themeWhite),
                  const SizedBox(
                    width: 10,
                  ),
                  circularIndicator("Occupied", AppColors.textHint),
                ],
              )
            ],
          ),
        ),
        Wrap(
          spacing: 16.0, // Space between items horizontally
          runSpacing: 16.0, // Space between rows
          children: bedNumbers.map<Widget>((bed) {
            return GestureDetector(
              onTap: () {
                if (!bed["is_active"]) {
                  bedSelectHandle(bed);
                  Navigator.pop(context as BuildContext);
                }
              },
              child: Container(
                width: (MediaQuery.of(context as BuildContext).size.width - 64) / 5, // 3 items per row
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: bed["is_active"]
                      ? AppColors.themeLite
                      : bed["user_bed"] == bedNo["user_bed"]
                          ? AppColors.theme
                          : AppColors.themeWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(83, 37, 37, 37),
                      blurRadius: 10, // Spread of the blur
                      offset: Offset(0, 4), // Horizontal and vertical offset
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      bed["user_bed"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: bed["is_active"]
                            ? AppColors.themeWhite
                            : bed["user_bed"] != bedNo["user_bed"]
                                ? AppColors.theme
                                : AppColors.themeWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
