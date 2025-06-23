import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper/helper.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/model/establishment_item.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class ExpenditureAddView extends StatefulWidget {
  const ExpenditureAddView({super.key});

  @override
  State<ExpenditureAddView> createState() => _ExpenditureAddViewState();
}

class _ExpenditureAddViewState extends State<ExpenditureAddView> {
  List<UserMealData> userMealList = [];
  List<EstablishmentItem> establishmentList = [];

  final validation = UserValidationStatus();

  List<ActiveUser> activeUserList = [];
  List<ActiveUser> selectedUserList = [];
  List<MeterReadingInputModel> meterReadingList = [];
  List<AdditionalExpendModule> additionalExpandList = [];
  List<MeterReading> monthlyMeterReadingList = [];

  dynamic expenditureDetails = [];

  bool isValid = false;

  @override
  void initState() {
    establishmentList.add(EstablishmentItem());
    super.initState();

    handleGetActiveUserList();
    handleSetActiveUserList();

    segmentNotifier.value = segmentNotifier.value.copyWith(
      isMeterActive: false,
      isAddition: false,
    );
  }

  handleSetActiveUserList() async {
    getActiveUserList();
    getActiveMeterList();
    getMonthlyReadingList();
  }

  handleGetActiveUserList() async {
    var data = await LocalStore().getStore(ListOfStoreKey.activeBorderList);
    var meterList = await LocalStore().getStore(ListOfStoreKey.getMonthlyMeterReadings);
    var expenditureData = await LocalStore().getStore(ListOfStoreKey.expenditureDetails);

    setState(() {
      expenditureDetails = expenditureData;
    });

    if (data is List) {
      setState(() {
        activeUserList = data.map((item) => ActiveUser.fromJson(item as Map<String, dynamic>)).toList();
      });
    }
    if (meterList is List) {
      setState(() {
        monthlyMeterReadingList = meterList.map((item) => MeterReading.fromJson(item as Map<String, dynamic>)).toList();
      });
    }
  }

  addBorderItem() {
    setState(() {
      establishmentList.add(EstablishmentItem());
    });
  }

  deleteRow(int index) {
    macaPrint("rowIndex $index");
    setState(() {
      establishmentList.removeAt(index);
    });
  }

  void updateInput(int index, int fieldIndex, dynamic value, {List<EstablishmentItem>? selectedUser}) {
    setState(() {
      switch (fieldIndex) {
        case 0:
          establishmentList[index].itemName = value;
          break;
        case 1:
          establishmentList[index].itemAmount = value;
          break;
      }
    });
  }

  handleGetSelectedUserList({bool? isGenericValid, bool? isMeterReading, bool? isAdditionalReading, bool? isMeterReadingNotEmpty, bool? isAdditionalReadingNotEmpty}) {
    macaPrint('isGenericValid: ${validation.isMeterReading}');

    macaPrint("isValid$isValid");
  }

  void validateFields() {
    setState(() {
      macaPrint("addValid$establishmentList");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
                onDoubleTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.theme,
                )),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Expenditure",
              style: TextStyle(color: AppColors.theme, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.themeWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<SegmentItemModule>(
                valueListenable: segmentNotifier,
                builder: (context, value, child) {
                  return Column(
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
                                "Establishment",
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
                      ListView.builder(
                        itemCount: establishmentList.length,
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
                                      hintText: 'Item',
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
                                    onChanged: (value) => updateInput(index, 1, double.parse(value)),
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
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isValid ? () async {} : null,
                    style: AppButtonStyles.elevatedButtonStyle(
                      backgroundColor: isValid ? AppColors.theme : AppColors.themeLite,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16), // spacing between buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showBedSelectionModal(context, 3);
                    },
                    style: AppButtonStyles.outlinedButtonStyle(),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 16.0, color: AppColors.themeLite),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
