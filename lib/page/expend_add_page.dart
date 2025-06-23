import 'package:flutter/material.dart';
import 'package:maca/common/animated_button/animation_button.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/helper/add_expense.dart';
import 'package:maca/model/data_model.dart';
import 'package:maca/models/global_model.dart';
import 'package:maca/provider/notification_provider.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';
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

  void updateItemAmount() {
    if (expenses.isNotEmpty) {
      for (var ex in expenses) {
        setState(() {
          totalAmount += ex.amount;
        });
        // Assuming `ex.amount` is numeric
      }
    }
    macaPrint("totalAmount$totalAmount");
  }

  void updateTotalExpense({int? index, String? value}) {
    expenses[index!] = ExpenseData(
      item: expenses[index].item,
      amount: double.tryParse(value!) ?? 0.0,
    );
    updateItemAmount();
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
                slotSegment("expense", shift, addExpense, expenses, updateTotalExpense),
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

@override
Widget slotSegment(
  type,
  dynamic shift,
  Function({ExpenseData data, ActionType action, int index}) onAddItem,
  List<ExpenseData> addItems,
  Function({int index, String? value}) updateTotalExpense,
) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      boxShadow: [AppBoxShadow.defaultBoxShadow],
      color: AppColors.themeWhite,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  type == "Start Date" ? "From" : "Expense",
                  style: AppTextStyles.inputLabel,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Ensure new item is added to both controllers and list

                onAddItem(data: const ExpenseData(item: "", amount: 0), action: ActionType.add); // Add a new empty expense
              },
              child: const Icon(
                Icons.add_circle_outlined,
                color: AppColors.theme,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          itemCount: addItems.length,
          itemBuilder: (BuildContext context, index) {
            TextEditingController itemController = TextEditingController(text: addItems[index].item);
            TextEditingController amountController = TextEditingController(text: addItems[index].amount == 0.0 ? "" : addItems[index].amount.toString());

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: itemController, // No more index errors
                    decoration: AppDateStyles.textFieldDecoration(
                      hintText: 'Enter item',
                      prefixIcon: Icons.local_grocery_store_rounded,
                    ),
                    style: const TextStyle(color: AppColors.themeLite),
                    onChanged: (value) {
                      addItems[index] = ExpenseData(
                        item: value,
                        amount: addItems[index].amount,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    // ignore: unrelated_type_equality_checks
                    controller: amountController, // No more index errors
                    decoration: AppDateStyles.textFieldDecoration(
                      hintText: 'Enter amount',
                      prefixIcon: Icons.currency_rupee_sharp,
                    ),
                    style: const TextStyle(color: AppColors.themeLite),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      (addItems[index] = ExpenseData(
                        item: addItems[index].item,
                        amount: double.tryParse(value) ?? 0.0,
                      ));

                      // (Optional) setState(() => this.total = total);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: AppColors.themeGray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      onAddItem(action: ActionType.delete, index: index);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: AppColors.theme,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
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
