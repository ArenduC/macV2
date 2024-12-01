import 'package:flutter/material.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/provider/notification_provider.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/service/app_messaging_service.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:provider/provider.dart';

class MarketingPage extends StatefulWidget {
  const MarketingPage({super.key});

  @override
  State<MarketingPage> createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage> {
  //for text controller
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  // for dynamic variable
  dynamic shift;
  dynamic startShift = false;
  dynamic endShift = false;
  dynamic loginData;

  @override
  void initState() {
    super.initState();
    getDataFromLocalStorage();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<Counter>(context, listen: false).notifyListeners();
      }
    });
  }

  //for fetching local stor data
  Future getDataFromLocalStorage() async {
    loginData = await getLocalStorageData("loginDetails");
    macaPrint(loginData);
  }

  // this method for getting date from user input
  Future<void> datePickerHandle(dynamic type, dynamic selectedShift) async {
    AppFunction().macaPrint(type);
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (datePicker != null) {
      switch (type) {
        case "Start Date":
          startDateController.text = datePicker.toString().split(" ")[0];
          break;
        case "End Date":
          endDateController.text = datePicker.toString().split(" ")[0];
          break;
      }
    }
  }

  Future<void> selectedShift(dynamic type, dynamic selectedShift) async {
    macaPrint(selectedShift, "selectedShift");
    setState(() {
      shift = selectedShift;
      if (type != null) {
        switch (type) {
          case "Start Date":
            startShift = selectedShift;
            break;
          case "End Date":
            endShift = selectedShift;
            break;
        }
      }
    });
  }

  Future<dynamic> marketingStatusUpdate() async {
    dynamic jsonBody = {
      "borderId": loginData["id"],
      "startDate": startDateController.text,
      "endDate": endDateController.text,
      "startShift": startShift,
      "endShift": endShift
    };
    macaPrint(jsonBody);
    dynamic response = await ApiService().apiCallService(
        endpoint: PostUrl().marketingStatusUpdate,
        method: ApiType().post,
        body: jsonBody);
    AppFunction().macaApiResponsePrintAndGet(response);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(builder: (context, countProvider, _) {
      print("notificationCount ${countProvider.count}");
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
              slotSegment("Start Date", startDateController, shift,
                  datePickerHandle, selectedShift),
              const SizedBox(height: 20),
              slotSegment("End Date", endDateController, shift,
                  datePickerHandle, selectedShift),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  marketingStatusUpdate();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.themeLite,
                  ),
                  child: const Text(
                    "Add shift",
                    style: TextStyle(color: AppColors.themeWhite),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

@override
Widget slotSegment(
    type,
    TextEditingController dateController,
    dynamic shift,
    Function(dynamic data, dynamic selectedShift) datePickerHandle,
    Function(dynamic data, dynamic selectedShift) selectedShift) {
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
          style: AppTextStyles.inputLabel,
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
                controller: dateController,
                decoration: AppDateStyles.textFieldDecoration(
                  hintText: 'Enter $type',
                  prefixIcon: Icons.calendar_month_rounded,
                ),
                style: const TextStyle(color: AppColors.themeLite),
                onTap: () {
                  datePickerHandle(type, "");
                }, // Text style
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SlotSwitch(
              initialStatus: false,
              onStatusChanged: (status) {
                macaPrint(status);
                selectedShift(type, status);
                // Callback receives updated status
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
    super.key,
    required this.initialStatus,
    required this.onStatusChanged,
  });

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
