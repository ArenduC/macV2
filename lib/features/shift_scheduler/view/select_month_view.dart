import 'package:flutter/material.dart';
import 'package:maca/features/shift_scheduler/model/shift_schedule.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: monthController,
          readOnly: true, // Prevents manual typing
          decoration: const InputDecoration(
            labelText: 'Select Month',
            suffixIcon: Icon(Icons.calendar_month),
          ),
          onTap: () async {
            // Open the date picker
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
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
        TextField(
          controller: numberOfBorderController,
          decoration: const InputDecoration(
            labelText: 'Enter Number of Borders',
          ),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {
            final updatedValue = MarketingShiftScheduleValue(
              month: int.tryParse(monthController.text) ?? 1,
              numberOfBorder: int.tryParse(numberOfBorderController.text) ?? 8,
              year: int.tryParse(yearController.text) ?? DateTime.now().year,
            );
            widget.onPressed!(updatedValue);
          },
          child: const Text('Regenerate'),
        ),
      ],
    );
  }
}
