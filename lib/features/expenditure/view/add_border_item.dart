import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/notifiers/added_border_item_notifier.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class AddBorderItem extends StatefulWidget {
  final List<ActiveUser> addedBorder;
  const AddBorderItem({super.key, this.addedBorder = const []});

  @override
  State<AddBorderItem> createState() => _AddBorderItemState();
}

class _AddBorderItemState extends State<AddBorderItem> {
  List<UserMealData> borderMealDetailsList = [];
  List<ActiveUser> userList = [];

  @override
  void initState() {
    addUserList();
    super.initState();
  }

  addUserList() async {
    var data = await LocalStore().getStore(ListOfStoreKey.activeBorderList);

    if (data is List) {
      setState(() {
        userList = data.map((item) => ActiveUser.fromJson(item as Map<String, dynamic>)).toList();
      });
    } else {
      macaPrint('Expected a List but got: ${data.runtimeType}');
    }
  }

  addBorderItem() {
    setState(() {
      borderMealDetailsList.add(UserMealData());
    });
  }

  deleteRow(int index) {
    macaPrint("rowIndex $index");
    setState(() {
      borderMealDetailsList.removeAt(index);
    });
  }

  void updateInput(int index, int fieldIndex, dynamic value, {List<UserMealData>? selectedUser}) {
    setState(() {
      switch (fieldIndex) {
        case 0:
          borderMealDetailsList[index].meal = value;
          break;
        case 1:
          borderMealDetailsList[index].deposit = value;
          break;
      }
    });
  }

  void validateFields() {
    setState(() {
      macaPrint("addValid$borderMealDetailsList");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.currency_rupee_rounded,
                    color: AppColors.theme,
                  ),
                  Text(
                    "Add Border Item",
                    style: TextStyle(color: AppColors.theme),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // addRow();
                      addBorderItem();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(color: AppColors.themeLite, borderRadius: BorderRadius.circular(50)),
                      child: const Icon(Icons.add, color: AppColors.themeWhite),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      validateFields();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(color: AppColors.themeWhite, borderRadius: BorderRadius.circular(50)),
                      child: const Icon(Icons.published_with_changes_rounded, color: AppColors.themeLite),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ValueListenableBuilder<List<AddedBorderItem>>(
            valueListenable: addedBorderListNotifier,
            builder: (context, value, child) {
              macaPrint("addedBorderItem$value");
              return ListView.builder(
                itemCount: value.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final borderData = value[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.theme, border: Border.all(width: 5, color: AppColors.theme), borderRadius: const BorderRadius.all(Radius.circular(11))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            borderData.name,
                            style: const TextStyle(color: AppColors.themeWhite),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) => updateInput(index, 0, value),
                                  decoration: AppFormInputStyles.textFieldDecoration(
                                    hintText: 'Item',
                                  ),
                                  style: const TextStyle(color: AppColors.theme),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: AppFormInputStyles.textFieldDecoration(
                                    hintText: 'Amount',
                                  ),
                                  style: const TextStyle(color: AppColors.theme),
                                  onChanged: (value) => updateInput(index, 1, double.parse(value)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
