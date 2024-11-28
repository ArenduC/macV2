import 'package:flutter/material.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MarketingPage extends StatefulWidget {
  const MarketingPage({super.key});

  @override
  State<MarketingPage> createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage> {
  final TextEditingController startDateControler = TextEditingController();
  final TextEditingController endDateControler = TextEditingController();

  Future<void> datePickerHandle(dynamic type) async {
    AppFunction().macaPrint(type);
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (datePicker != null) {
      switch (type) {
        case "Start Date":
          startDateControler.text = datePicker.toString().split(" ")[0];
          break;
        case "End Date":
          endDateControler.text = datePicker.toString().split(" ")[0];
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Marketing'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            slotSegment("Start Date", startDateControler, datePickerHandle),
            const SizedBox(height: 20),
            slotSegment("End Date", endDateControler, datePickerHandle)
          ],
        ),
      ),
    );
  }
}

@override
Widget slotSegment(type, TextEditingController dateControler,
    Function(dynamic data) datePickerHandle) {
  return (Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
        boxShadow: [AppBoxShadow.defaultBoxShadow],
        color: AppColors.themeWhite,
        borderRadius: BorderRadius.all(Radius.circular(12))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type == "Start Date" ? "From" : "To"),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                controller: dateControler,
                decoration: AppDateStyles.textFieldDecoration(
                  hintText: 'Enter $type',
                  prefixIcon: Icons.calendar_month_rounded,
                ),
                style: const TextStyle(color: AppColors.themeLite),
                onTap: () {
                  datePickerHandle(type);
                }, // Text style
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text("Slote")
          ],
        )
      ],
    ),
  ));
}
