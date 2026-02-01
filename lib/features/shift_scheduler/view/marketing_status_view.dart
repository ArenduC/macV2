import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/features/shift_scheduler/model/shift_schedule.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/page/marketing_page.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MarketingStatusView extends StatelessWidget {
  final ShiftAssignment data;
  const MarketingStatusView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool status = data.status == 3 ? false : true;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [AppBoxShadow.defaultBoxShadow],
          color: AppColors.themeWhite,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              height: 10,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: getMarketStatusColor(data.status),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 18, top: 8, right: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/APPSVGICON/profileIcon.svg',
                            width: 40,
                            height: 40,
                            colorFilter: status ? ColorFilter.mode(AppColors.themeLite, BlendMode.dst) : const ColorFilter.mode(Color.fromARGB(108, 217, 217, 217), BlendMode.dstIn),
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.marketingUser ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: status ? AppColors.theme : AppColors.completed,
                                ),
                              ),
                              Text(
                                getMarketStatus(data.status),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: status ? AppColors.themeLite : AppColors.completed,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      shiftView({
                        "startDate": data.startDate,
                        "endDate": data.endDate,
                        "startShift": data.startShift,
                        "endShift": data.endShift,
                        "active": status,
                      })
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
