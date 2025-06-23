import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class AdditionalExpendView extends StatefulWidget {
  final Function(List<AdditionalExpendModule>)? onSubmit;
  const AdditionalExpendView({super.key, this.onSubmit});

  @override
  State<AdditionalExpendView> createState() => _AdditionalExpendViewState();
}

class _AdditionalExpendViewState extends State<AdditionalExpendView> {
  List<AdditionalExpendModule> inputList = [];
  List<ActiveUser> convertedList = [];

  @override
  void initState() {
    super.initState();
    inputList.add(AdditionalExpendModule()); // Add one by default
  }

  void addRow() {
    setState(() {
      inputList.add(AdditionalExpendModule());
    });
  }

  void deleteRow(int index) {
    macaPrint("rowIndex $index");
    setState(() {
      inputList.removeAt(index);
    });
  }

  void updateInput(int index, int fieldIndex, String value, {List<ActiveUser>? selectedUser}) {
    setState(() {
      switch (fieldIndex) {
        case 0:
          inputList[index].input1 = value;
          break;
        case 1:
          inputList[index].input2 = value;
          break;
        case 2:
          inputList[index].input3 = selectedUser!;
          break;
      }
    });
  }

  void printValues() {
    macaPrint(inputList);
    if (widget.onSubmit != null) {
      widget.onSubmit!(inputList); // Pass your list here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    "Additional expend",
                    style: TextStyle(color: AppColors.theme),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      addRow();
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
                      printValues();
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
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: inputList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => updateInput(index, 0, value),
                        decoration: AppFormInputStyles.textFieldDecoration(
                          hintText: 'Purpose',
                        ),
                        style: const TextStyle(color: AppColors.theme),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: AppFormInputStyles.textFieldDecoration(
                          hintText: 'Amount',
                        ),
                        style: const TextStyle(color: AppColors.theme),
                        onChanged: (value) => updateInput(index, 1, value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showBedSelectionModal(context, 2,
                              selectedUsers: inputList[index].input3,
                              onUserSelected: (data) => {
                                    setState(() {
                                      updateInput(index, 2, "data", selectedUser: data);
                                      convertedList = data;
                                    })
                                  });
                        },
                        style: AppButtonStyles.outlinedButtonStyle(),
                        child: inputList[index].input3.isEmpty ? const Text("Border") : Text("${inputList[index].input3.length}"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => deleteRow(index),
                      style: AppButtonStyles.outlinedButtonStyle(),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.themeLite,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
