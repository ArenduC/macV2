import 'package:flutter/material.dart';
import 'package:maca/features/add_marketing_details/model/add_item.dart';
import 'package:maca/features/add_marketing_details/model/data_model.dart';
import 'package:maca/models/global_model.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

@override
Widget slotSegment(
  type,
  dynamic shift,
  Function({ExpenseData data, ActionType action, int index}) onAddItem,
  List<ExpenseData> addItems,
) {
  return ValueListenableBuilder<AddItem>(
    valueListenable: addItemNotifier,
    builder: (context, value, child) {
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

                    onAddItem(data: const ExpenseData(item: "", amount: 0), action: ActionType.add);
                    // Add a new empty expense
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
                        onChanged: (e) {
                          (addItems[index] = ExpenseData(
                            item: addItems[index].item,
                            amount: double.tryParse(e) ?? 0.0,
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
    },
  );
}
