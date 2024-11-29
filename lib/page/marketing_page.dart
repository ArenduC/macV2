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
        Text(
          type == "Start Date" ? "From" : "To",
          style: AppTextStyles.inputLable,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
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
            SlotSwitch(
              initialStatus: false,
              onStatusChanged: (status) {
                macaPrint(status); // Callback receives updated status
              },
            )
          ],
        )
      ],
    ),
  ));
}

class SlotSwitch extends StatefulWidget {
  final bool initialStatus; // Initial data
  final ValueChanged<bool> onStatusChanged;
  const SlotSwitch({
    Key? key,
    required this.initialStatus,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  _SlotSwitchState createState() => _SlotSwitchState();
}

class _SlotSwitchState extends State<SlotSwitch> {
  late bool switchStatus;

  @override
  void initState() {
    super.initState();
    switchStatus = widget.initialStatus; // Initialize with the received data
  }

  void switchState() {
    setState(() {
      switchStatus = !switchStatus;
    });
    widget.onStatusChanged(switchStatus);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(5),
        height: 45,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: switchStatus ? AppColors.themeLite : AppColors.themeWhite,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(129, 0, 0, 0).withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ], // Replace with AppColors.themeGray if available
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Night",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.themeWhite),
                  ),
                  Text(
                    "Day",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.themeLite),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: 0,
              bottom: 0,
              left: switchStatus ? 45 : 0,
              right: switchStatus ? 0 : 45,
              child: GestureDetector(
                onTap: switchState,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 45,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: switchStatus
                          ? AppColors.themeWhite
                          : AppColors.themeLite,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(129, 0, 0, 0)
                              .withOpacity(0.2),
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: const Offset(0, 1),
                        ),
                      ]),
                  child: Icon(
                    switchStatus ? Icons.nightlight : Icons.sunny,
                    color: switchStatus
                        ? AppColors.themeLite
                        : AppColors.themeWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        switchState();
      },
    );
  }
}
