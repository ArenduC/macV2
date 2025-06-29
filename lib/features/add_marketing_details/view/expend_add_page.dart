import 'package:flutter/material.dart';
import 'package:maca/common/animated_button/animation_button.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/add_marketing_details/view/slot_segment.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/features/add_marketing_details/helper/add_expense.dart';
import 'package:maca/features/add_marketing_details/model/data_model.dart';
import 'package:maca/models/global_model.dart';
import 'package:maca/provider/notification_provider.dart';
import 'package:maca/service/api_service.dart';
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
  dynamic code;
  double totalAmount = 0;

  List<ExpenseData> expenses = [const ExpenseData(item: "", amount: 0)];

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

  void addExpense({ExpenseData? data, ActionType? action, int? index}) {
    if (action == ActionType.add) {
      setState(() {
        expenses.add(data!);
        itemController.text = data.item;
        amountController.text = data.amount.toString();
      });
    } else if (action == ActionType.delete) {
      setState(() {
        expenses.removeAt(index!);
        itemController.text = '';
        amountController.text = '';
      });
    }
  }

  // this method for getting date from user input

  Future<dynamic> marketingStatusUpdate() async {
    List<Map<String, dynamic>> jsonList = expenses.map((e) => e.toJson()).toList();

    setState(() {
      code = emptyArrayCheck(context: context, data: expenses)["code"];
    });
    if (emptyArrayCheck(context: context, data: expenses)["status"]) {
      return;
    }

    dynamic jsonBody = {
      "user_id": loginData[0]["user_id"],
      "items": jsonList,
    };

    macaPrint(jsonBody);
    macaPrint(jsonList);
    dynamic response = await ApiService().apiCallService(endpoint: PostUrl().addExpense, method: ApiType().post, body: jsonBody);
    dynamic data = AppFunction().macaApiResponsePrintAndGet(data: response);
    setState(() {
      code = 200;
      isSuccess = data["isSuccess"];
      expenses = [const ExpenseData(item: "", amount: 0)];
    });
    Future.delayed(const Duration(seconds: 2), () {
      // Action after timeout
      setState(() {
        isSuccess = false;
        code = 100;
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
            child: Column(
              key: const ValueKey('inputFieldsView'), // Unique key for this child
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                slotSegment("expense", shift, addExpense, expenses),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    marketingStatusUpdate();
                  },
                  child: AnimationButton(
                    buttonText: "Add Expense",
                    onPressed: () {
                      marketingStatusUpdate();
                      return null;
                    },
                    data: expenses,
                    statusCode: code,
                  ),
                )
              ],
            ),
          ));
    });
  }
}
