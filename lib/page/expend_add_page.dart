import 'package:flutter/material.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/provider/notification_provider.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:maca/widget/app_common_widget.dart';
import 'package:provider/provider.dart';

class ExpendAddPage extends StatefulWidget {
  const ExpendAddPage({super.key});

  @override
  State<ExpendAddPage> createState() => _ExpendAddPageState();
}

class _ExpendAddPageState extends State<ExpendAddPage> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  // for dynamic variable
  dynamic shift;
  dynamic startShift = false;
  dynamic endShift = false;
  dynamic loginData;
  dynamic isSuccess = false;

  @override
  void initState() {
    super.initState();
    getDataFromLocalStorage();
  }

  //for fetching local stor data
  Future getDataFromLocalStorage() async {
    loginData = await getLocalStorageData("loginDetails");
    macaPrint(loginData);
  }

  // this method for getting date from user input

  Future<dynamic> marketingStatusUpdate() async {
    dynamic jsonBody = {
      "user_id": loginData[0]["user_id"],
      "item": itemController.text,
      "marketing_amount": amountController.text,
    };
    macaPrint(jsonBody);
    dynamic response = await ApiService().apiCallService(endpoint: PostUrl().addExpense, method: ApiType().post, body: jsonBody);
    dynamic data = AppFunction().macaApiResponsePrintAndGet(response);
    setState(() {
      isSuccess = data["isSuccess"];
      itemController.text = '';
      amountController.text = '';
    });
    Future.delayed(const Duration(seconds: 2), () {
      // Action after timeout
      setState(() {
        isSuccess = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(builder: (context, countProvider, _) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300), // Duration of animation
            switchInCurve: Curves.easeIn, // Curve for entering widget
            switchOutCurve: Curves.easeOut, // Curve for exiting widget
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: isSuccess
                ? const Column(
                    key: ValueKey('successView'), // Unique key for this child
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [SuccessView()],
                  )
                : Column(
                    key: const ValueKey('inputFieldsView'), // Unique key for this child
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      slotSegment("expense", itemController, amountController, shift),
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
                            "Add expense",
                            style: TextStyle(color: AppColors.themeWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
          ));
    });
  }
}

@override
Widget slotSegment(
  type,
  TextEditingController itemController,
  TextEditingController amountController,
  dynamic shift,
) {
  return (Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(boxShadow: [AppBoxShadow.defaultBoxShadow], color: AppColors.themeWhite, borderRadius: BorderRadius.all(Radius.circular(12))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type == "Start Date" ? "From" : "Expense",
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
                controller: itemController,
                decoration: AppDateStyles.textFieldDecoration(
                  hintText: 'Enter item',
                  prefixIcon: Icons.local_grocery_store_rounded,
                ),
                style: const TextStyle(color: AppColors.themeLite),
                // Text style
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                controller: amountController,
                decoration: AppDateStyles.textFieldDecoration(
                  hintText: 'Enter amount',
                  prefixIcon: Icons.currency_rupee_sharp,
                ),
                style: const TextStyle(color: AppColors.themeLite),
                // Text style
              ),
            ),
          ],
        )
      ],
    ),
  ));
}

@override
Widget successView() {
  return const Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
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
  ));
}
