import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper/helper.dart';

import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MeterReadingView extends StatefulWidget {
  final Function(List<MeterReadingInputModel>)? onSubmit;
  const MeterReadingView({super.key, required this.onSubmit});

  @override
  State<MeterReadingView> createState() => _MeterReadingViewState();
}

class _MeterReadingViewState extends State<MeterReadingView> {
  List<TextEditingController> inputControllers = [];
  String inputMeterReadingControllers = "";
  List<MeterReadingInputModel> inputList = [];
  List<ActiveUser> convertedList = [];

  @override
  void initState() {
    super.initState();
    inputList.add(MeterReadingInputModel());

    macaPrint("convertedList$convertedList");
  }

  void addRow() {
    setState(() {
      inputList.add(MeterReadingInputModel());
    });
  }

  void deleteRow(int index) {
    macaPrint("rowIndex $index");
    setState(() {
      inputList.removeAt(index);
    });
  }

  void updateInput(int index, int fieldIndex, String value, {List<ActiveUser>? selectedUser}) {
    macaPrint("selectedUser$selectedUser");
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

  void printValues() async {
    macaPrint(inputList);
    if (widget.onSubmit != null) {
      widget.onSubmit!(inputList); // Pass your list here
    }
    for (var meter in inputList) {
      var jsonObject = {"meterId": meter.input1, "meterReading": meter.input2};

      await addMeterReading(context, jsonObject);
    }
    AppFunction().macaApiResponsePrintAndGet(snackBarView: true, context: context, snackBarMessage: "Meter reading successfully added", data: "");
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
                    Icons.gas_meter_rounded,
                    color: AppColors.theme,
                  ),
                  Text(
                    "Meter reading",
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
                      child: TextField(
                        controller: TextEditingController(text: inputMeterReadingControllers != "" ? "M${inputList[index].input1}" : ""),
                        onChanged: (value) => updateInput(index, 0, value),
                        decoration: AppFormInputStyles.textFieldDecoration(
                            hintText: 'Meter',
                            suffixIcon: Icons.arrow_drop_down_rounded,
                            onSuffixIconTap: () => {
                                  showBedSelectionModal(context, 4,
                                      selectedMeterId: int.tryParse(inputList[index].input1) ?? 0,
                                      onMeterSelected: (data) => {
                                            setState(() {
                                              updateInput(index, 0, (data.first.id).toString());
                                              inputMeterReadingControllers = inputList[index].input1;
                                              macaPrint("meterSelectedId$data");
                                            }),
                                          })
                                }),
                        style: const TextStyle(color: AppColors.theme),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: AppFormInputStyles.textFieldDecoration(
                            hintText: 'Unit',
                            suffixIcon: Icons.arrow_drop_down_rounded,
                            onSuffixIconTap: () => {
                                  showBedSelectionModal(
                                    context,
                                    5,
                                    selectedMeterId: int.tryParse(inputList[index].input1) ?? 0,
                                  )
                                }),
                        style: const TextStyle(color: AppColors.theme),
                        onChanged: (value) => updateInput(index, 1, value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: inputControllers.isNotEmpty ? "${inputList[index].input3.length}" : ""),
                        readOnly: true,
                        decoration: AppFormInputStyles.textFieldDecoration(
                            hintText: 'Border',
                            suffixIcon: Icons.arrow_drop_down_rounded,
                            onSuffixIconTap: () => {
                                  showBedSelectionModal(context, 2,
                                      selectedUsers: inputList[index].input3,
                                      meterReadingDetails: inputList,
                                      onUserSelected: (data) => {
                                            setState(() {
                                              inputList[index].input3 = [];
                                              if (inputControllers.length <= index) {
                                                inputControllers.add(TextEditingController());
                                              }
                                            }),
                                            updateInput(index, 2, "data", selectedUser: data)
                                          })
                                }),
                        style: const TextStyle(color: AppColors.theme),
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
