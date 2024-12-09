import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

//this is for API success screen view
class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle,
          size: 50,
          color: AppColors.themeLite,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Successfully item added",
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.theme),
        )
      ],
    );
  }
}

//this for switch

class SwitchView extends StatefulWidget {
  const SwitchView({super.key});

  @override
  State<SwitchView> createState() => _SwitchViewState();
}

class _SwitchViewState extends State<SwitchView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CurrentManagerView extends StatefulWidget {
  final dynamic data;
  const CurrentManagerView({super.key, required this.data});

  @override
  State<CurrentManagerView> createState() => _CurrentManagerViewState();
}

class _CurrentManagerViewState extends State<CurrentManagerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
            boxShadow: [AppBoxShadow.defaultBoxShadow],
            color: AppColors.themeWhite,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Stack(children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  color: AppColors.themeGray,
                ),
                child: Text(
                  formatCustomDate((DateTime.now()).toString())["Month"],
                  style: AppTextStyles.cardPillTextStyle,
                ),
              )),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/APPSVGICON/profileIcon.svg',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Manager",
                          style: AppTextStyles.cardHeaderLabelStyle,
                        ),
                        Text(
                          widget.data,
                          style: AppTextStyles.cardHeader2LabelStyle,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ]));
  }
}

class ExpenditureTiles extends StatefulWidget {
  const ExpenditureTiles({super.key});

  @override
  State<ExpenditureTiles> createState() => _ExpenditureTilesState();
}

class _ExpenditureTilesState extends State<ExpenditureTiles> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    right: 8), // Add some spacing around containers
                decoration: const BoxDecoration(
                  boxShadow: [AppBoxShadow.defaultBoxShadow],
                  color: AppColors.themeWhite,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.money),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Expenditure"),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 8.0), // Add some spacing around containers
                decoration: const BoxDecoration(
                  boxShadow: [AppBoxShadow.defaultBoxShadow],
                  color: AppColors.themeWhite,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Revenue"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
