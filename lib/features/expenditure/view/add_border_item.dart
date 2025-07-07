import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/notifiers/added_border_item_notifier.dart';
import 'package:maca/features/expenditure/service/individual_marketing.dart';
import 'package:maca/features/marketing_details/marketing_details_model.dart';
import 'package:maca/features/marketing_details/view/individual_details.dart';
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
  List<bool> isGuestMealList = [];
  List<int> sliderValues = [];
  MonthData monthlyIndividualData = MonthData(month: "", data: []);

  @override
  void initState() {
    getIndividualData();
    addUserList();

    super.initState();
  }

  getIndividualData() async {
    var data = await individualMarketing();
    setState(() {
      monthlyIndividualData = data;
    });
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

  void validateFields() {
    setState(() {
      macaPrint("addValid$borderMealDetailsList");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                    validateFields();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(color: AppColors.themeWhite, borderRadius: BorderRadius.circular(50)),
                    child: Icon(Icons.published_with_changes_rounded, color: AppColors.themeLite),
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
            if (isGuestMealList.length != value.length) {
              isGuestMealList = List.filled(value.length, false);
            }
            if (sliderValues.length != value.length) {
              sliderValues = List.filled(value.length, 35);
            }
            return Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom - 206,
                child: ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final borderData = value[index];

                    final expenditureData = getIndividualExpenditure(monthlyIndividualData, borderData.id);
                    macaPrint("expenditureData$expenditureData");

                    if (expenditureData != 0.0) {
                      addedBorderListNotifier.value[index].expenditure = expenditureData.toInt();
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all(width: 1, color: AppColors.themeLite), borderRadius: const BorderRadius.all(Radius.circular(11))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            borderData.name.length > 10 ? '${borderData.name.substring(0, 8)}...' : borderData.name,
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              color: AppColors.theme,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.themeLite),
                                            child: Text(
                                              borderData.mealCount.toStringAsFixed(0),
                                              style: TextStyle(color: AppColors.themeWhite, fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Slider(
                                        thumbColor: AppColors.themeLite,
                                        activeColor: AppColors.themeLite,
                                        inactiveColor: AppColors.themeLite.withOpacity(.2),
                                        min: 35,
                                        max: 62,

                                        divisions: 27,
                                        // 62 - 35 = 27 steps
                                        label: borderData.mealCount.toStringAsFixed(0),
                                        value: borderData.mealCount.toDouble(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            addedBorderListNotifier.value[index].mealCount = newValue.toInt();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isGuestMealList[index] = !isGuestMealList[index];
                                        addedBorderListNotifier.value[index].isGestMeal = isGuestMealList[index];
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Gest",
                                          style: TextStyle(
                                            color: AppColors.themeLite,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        borderData.isGestMeal
                                            ? Icon(
                                                Icons.check_box_rounded,
                                                color: AppColors.themeLite,
                                              )
                                            : Icon(
                                                Icons.check_box_outline_blank_rounded,
                                                color: AppColors.themeLite,
                                                opticalSize: Checkbox.width,
                                                weight: 100,
                                              ),
                                      ],
                                    ))
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: (borderData.deposit == 0.0) ? null : borderData.deposit.toString(),
                                        ),
                                        onChanged: (value) => addedBorderListNotifier.value[index].deposit = int.parse(value),
                                        keyboardType: TextInputType.number,
                                        decoration: AppFormInputStyles.textFieldDecoration(
                                          hintText: 'Deposit',
                                        ),
                                        style: TextStyle(color: AppColors.theme),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: expenditureData != 0.0 ? expenditureData.toString() : ((borderData.expenditure == 0.0) ? null : borderData.expenditure.toString()),
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: AppFormInputStyles.textFieldDecoration(
                                          hintText: 'Expend',
                                        ),
                                        style: TextStyle(color: AppColors.theme),
                                        onChanged: (value) => addedBorderListNotifier.value[index].expenditure = int.parse(value),
                                      ),
                                    ),
                                  ],
                                ),
                                ...[
                                  if (borderData.isGestMeal) ...[
                                    const SizedBox(height: 5),
                                    TextFormField(
                                      controller: TextEditingController(
                                        text: (borderData.gestMeal == 0.0) ? null : borderData.gestMeal.toString(),
                                      ),
                                      onChanged: (v) => addedBorderListNotifier.value[index].gestMeal = int.parse(v),
                                      keyboardType: TextInputType.number,
                                      decoration: AppFormInputStyles.textFieldDecoration(
                                        hintText: 'Gest meal',
                                      ),
                                      style: TextStyle(color: AppColors.theme),
                                    ),
                                  ]
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
