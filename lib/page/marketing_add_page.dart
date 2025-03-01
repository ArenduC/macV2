import 'package:flutter/material.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/helper/maca_global_helper.dart';
import 'package:maca/provider/notification_provider.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:maca/widget/app_common_widget.dart';
import 'package:provider/provider.dart';

class MarketingAddPage extends StatefulWidget {
  const MarketingAddPage({super.key});

  @override
  State<MarketingAddPage> createState() => _MarketingAddPageState();
}

class _MarketingAddPageState extends State<MarketingAddPage> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  // for dynamic variable
  dynamic shift;
  dynamic startShift = false;
  dynamic endShift = false;
  dynamic viewState = 2;
  dynamic loginData;
  dynamic marketingStatus;

  @override
  void initState() {
    super.initState();
    getDataFromLocalStorage();
  }

  getProviderController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<Counter>(context, listen: false).notifyListeners();
      }
    });
  }

  //For fetching local stor data
  Future getDataFromLocalStorage() async {
    loginData = await getLocalStorageData("loginDetails");
    individualMarketStatusUpdate(loginData[0]["user_id"]);
    macaPrint(loginData);
    macaPrint(marketingStatus);
  }

  // This method for getting date from user input
  Future<void> datePickerHandle(dynamic type, dynamic selectedShift) async {
    macaPrint(type);
    DateTime now = DateTime.now();
    DateTime? datePicker = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(2020), lastDate: DateTime(now.year + 1));
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

  /* This for marketing shift selection 
   1. It contains two option like "Start Date" and "End Date"
*/
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

  // This is for updating marketing status individually
  Future<dynamic> marketingStatusUpdate() async {
    dynamic jsonBody = {
      "borderId": loginData[0]["user_id"],
      "startDate": startDateController.text,
      "endDate": endDateController.text,
      "startShift": booleanConverter(startShift),
      "endShift": booleanConverter(endShift)
    };

    dynamic response = await ApiService().apiCallService(endpoint: PostUrl().marketingStatusUpdate, method: ApiType().post, body: jsonBody);
    dynamic data = AppFunction().macaApiResponsePrintAndGet(response);

    setState(() {
      if (data["isSuccess"] == true) {
        viewState = 0;
        context.read<WidgetUpdate>().increment();
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      individualMarketStatusUpdate(loginData[0]["user_id"]);
    });
  }

  Future<dynamic> individualMarketStatusUpdate(dynamic data) async {
    macaPrint("userId: $data");
    dynamic jsonBody = {"user_id": data};
    dynamic response = await ApiService().apiCallService(endpoint: PostUrl().individualMarketStatus, method: ApiType().post, body: jsonBody);
    dynamic value = AppFunction().macaApiResponsePrintAndGet(response);
    if (mounted) {
      setState(() {
        marketingStatus = value["data"][0];
        if (marketingStatus["status"] != 0) {
          viewState = 1;
        } else {
          viewState = 2;
        }
      });
    }
  }

  /* This is for control the view on the basis of condition 
   1. Case 0 for after successfully submit the updated data in individual segment
   2. Case 1 if the user have already booked its slot then it will show the selected data
   3. Case default it will show the input field for the booking slot
*/
  getViewController(dynamic data) {
    macaPrint(data);
    switch (data) {
      case 0:
        return const SuccessView();
      case 1:
        return marketDetailsView(marketingStatus);
      default:
        return inputSegment(startDateController, endDateController, shift, datePickerHandle, selectedShift, marketingStatusUpdate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), // Animation duration
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: getViewController(viewState),
        key: ValueKey<int>(viewState), // Unique key for AnimatedSwitcher
      ),
    );
  }
}

@override
Widget inputSegment(TextEditingController startDateController, TextEditingController endDateController, dynamic shift, Function(dynamic data, dynamic selectedShift) datePickerHandle,
    Function(dynamic data, dynamic selectedShift) selectedShift, Function marketingStatusUpdate) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      slotSegment("Start Date", startDateController, shift, datePickerHandle, selectedShift),
      const SizedBox(height: 20),
      slotSegment("End Date", endDateController, shift, datePickerHandle, selectedShift),
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
  );
}

@override
Widget slotSegment(
    type, TextEditingController dateController, dynamic shift, Function(dynamic data, dynamic selectedShift) datePickerHandle, Function(dynamic data, dynamic selectedShift) selectedShift) {
  return (Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(boxShadow: [AppBoxShadow.defaultBoxShadow], color: AppColors.themeWhite, borderRadius: BorderRadius.all(Radius.circular(12))),
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.themeWhite),
                  ),
                  Text(
                    "Day",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.themeLite),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: switchStatus ? AppColors.themeWhite : AppColors.themeLite, boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(129, 0, 0, 0).withOpacity(0.2),
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: const Offset(0, 1),
                    ),
                  ]),
                  child: Icon(
                    switchStatus ? Icons.nightlight : Icons.sunny,
                    color: switchStatus ? AppColors.themeLite : AppColors.themeWhite,
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

@override
Widget marketDetailsView(dynamic data) {
  return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [Text(getMarketStatus(data["status"]))],
      ));
}
