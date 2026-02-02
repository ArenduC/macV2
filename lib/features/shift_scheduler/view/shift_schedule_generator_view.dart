import 'package:flutter/material.dart';
import 'package:maca/common/loading_component.dart';
import 'package:maca/features/shift_scheduler/helper/shift_schedule_generator.dart';
import 'package:maca/features/shift_scheduler/model/shift_schedule.dart';
import 'package:maca/features/shift_scheduler/view/marketing_status_view.dart';
import 'package:maca/features/shift_scheduler/view/select_month_view.dart';
import 'package:maca/features/shift_scheduler/view/shift_schedule_action_button.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/colors/app_colors.dart';

class ShiftScheduleGeneratorView extends StatefulWidget {
  final dynamic shiftAssignment;
  const ShiftScheduleGeneratorView({super.key, this.shiftAssignment = const []});

  @override
  State<ShiftScheduleGeneratorView> createState() => _ShiftScheduleGeneratorViewState();
}

class _ShiftScheduleGeneratorViewState extends State<ShiftScheduleGeneratorView> {
  bool refresh = false;
  List<ShiftAssignment> shiftAssignments = [];
  List<ShiftAssignment> rawShifts = [];
  int selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    rawShifts = generateShiftsAccurate(year: DateTime.now().year, month: DateTime.now().month, numberOfPeople: 1);
  }

  Future<void> _onRefresh() async {
    setState(() {
      refresh = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      refresh = false;
    });
  }

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
              "Shift Schedule",
              style: TextStyle(color: AppColors.theme, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.themeWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: rawShifts.isEmpty || refresh
            ? const LoadingComponent()
            : Column(children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _onRefresh(),
                    child: ListView.separated(
                      itemCount: rawShifts.length,
                      itemBuilder: (context, index) {
                        final user = rawShifts[index];
                        return Container(
                          // Align text to the left
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                          child: MarketingStatusView(
                            key: UniqueKey(),
                            data: user,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 4,
                      ),
                    ),
                  ),
                ),
                SelectMonthView(
                  onPressed: (select) {
                    setState(() {
                      macaPrint(select.month, select.numberOfBorder);
                      selectedYear = select.year;
                      rawShifts = generateShiftsAccurate(year: select.year, month: select.month, numberOfPeople: select.numberOfBorder);
                    });
                  },
                ),
                ShiftScheduleActionButton(
                  onPressed: () => actionButtonStateUpdate(rawShifts),
                  label: "Publish",
                ),
              ]),
      ),
    );
  }
}
