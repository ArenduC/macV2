import 'package:flutter/material.dart';
import 'package:maca/features/shift_scheduler/helper/share_shift_option.dart';
import 'package:maca/features/shift_scheduler/helper/shift_schedule_generator.dart';
import 'package:maca/features/shift_scheduler/model/shift_schedule.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class SelectMonthView extends StatefulWidget {
  final Function(MarketingShiftScheduleValue)? onPressed;

  const SelectMonthView({super.key, this.onPressed});

  @override
  State<SelectMonthView> createState() => _SelectMonthViewState();
}

class _SelectMonthViewState extends State<SelectMonthView> {
  TextEditingController monthController = TextEditingController();
  TextEditingController numberOfBorderController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  late final MarketingShiftScheduleValue finalUpdatedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.themeWhite, borderRadius: const BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26)), boxShadow: [
        BoxShadow(
          color: AppColors.theme.withOpacity(.1),
          blurRadius: 20,
          spreadRadius: 1,
          offset: const Offset(0, -5),
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: monthController,
              readOnly: true, // Prevents manual typing

              decoration: AppFormInputStyles.textFieldDecoration(
                hintText: 'Select Month',
                prefixIcon: Icons.calendar_month,
              ),
              style: TextStyle(color: AppColors.header1),
              onTap: () async {
                // Open the date picker
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  // Optional: This limits the picker to a more compact month/year view in some versions
                  initialDatePickerMode: DatePickerMode.day,
                );

                if (pickedDate != null) {
                  setState(() {
                    // Set only the month number (1-12) to the controller
                    monthController.text = pickedDate.month.toString();
                    yearController.text = pickedDate.year.toString();
                  });
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: numberOfBorderController,
              keyboardType: TextInputType.number,
              decoration: AppFormInputStyles.textFieldDecoration(
                hintText: 'Enter Number of Borders',
                prefixIcon: Icons.people,
              ),
              style: TextStyle(color: AppColors.header1),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final updatedValue = MarketingShiftScheduleValue(
                        month: int.tryParse(monthController.text) ?? 1,
                        numberOfBorder: int.tryParse(numberOfBorderController.text) ?? 8,
                        year: int.tryParse(yearController.text) ?? DateTime.now().year,
                      );
                      widget.onPressed!(updatedValue);
                      finalUpdatedValue = updatedValue;
                    },
                    style: AppButtonStyles.outlinedButtonStyle(),
                    child: const Text('Regenerate'),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      shareShiftSchedule(generateShiftsAccurate(year: finalUpdatedValue.year, month: finalUpdatedValue.month, numberOfPeople: finalUpdatedValue.numberOfBorder));
                    },
                    style: AppButtonStyles.elevatedButtonStyle(backgroundColor: AppColors.theme),
                    child: const Text(
                      'Share',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
