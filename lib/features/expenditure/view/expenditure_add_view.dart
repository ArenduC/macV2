import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper/helper.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/features/expenditure/helper/empty_border_list_check.dart';
import 'package:maca/features/expenditure/helper/empty_field_check.dart';
import 'package:maca/features/expenditure/helper/establishment_calculation.dart';
import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/model/establishment_item.dart';
import 'package:maca/features/expenditure/notifiers/added_border_item_notifier.dart';
import 'package:maca/features/expenditure/pdf/repaint_widget.dart';
import 'package:maca/features/expenditure/view/add_border_item.dart';
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
  bool isBorderAddedView = false;

  @override
  void initState() {
    establishmentList.add(EstablishmentItem());
    handleGetActiveUserList();
    handleSetActiveUserList();
    segmentNotifier.value = segmentNotifier.value.copyWith(
      isMeterActive: false,
      isAddition: false,
    );

    super.initState();
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

  addBorderItemMethod() {
    setState(() {
      establishmentList.add(EstablishmentItem());
      establishmentNotifier.value = establishmentList;
    });
  }

  deleteRow(int index) {
    macaPrint("rowIndex $index");
    setState(() {
      establishmentList.removeAt(index);
    });
  }

  handleGetSelectedUserList({bool? isGenericValid, bool? isMeterReading, bool? isAdditionalReading, bool? isMeterReadingNotEmpty, bool? isAdditionalReadingNotEmpty}) {
    macaPrint('isGenericValid: ${validation.isMeterReading}');

    macaPrint("isValid$isValid");
  }

  void validateFields() {
    setState(() {
      macaPrint("addValid${establishmentNotifier.value}");
      emptyExpenditureArrayCheck(context: context, data: establishmentNotifier.value);
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
            Expanded(
              child: ValueListenableBuilder<List<EstablishmentItem>>(
                  valueListenable: establishmentNotifier,
                  builder: (context, value, child) {
                    return isBorderAddedView
                        ? const AddBorderItem()
                        : Column(
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
                                          addBorderItemMethod();
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
                              Flexible(
                                child: AnimatedPadding(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom - 206,
                                    child: ListView.builder(
                                      itemCount: value.length,
                                      itemBuilder: (context, index) {
                                        final establishmentData = value[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: TextEditingController(
                                                    text: establishmentData.itemName?.isEmpty == true ? null : establishmentData.itemName,
                                                  ),
                                                  onChanged: (e) => {establishmentNotifier.value[index].itemName = e},
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
                                                  controller: TextEditingController(
                                                    text: (establishmentData.itemAmount == null || establishmentData.itemAmount == 0.0) ? null : establishmentData.itemAmount.toString(),
                                                  ),
                                                  decoration: AppFormInputStyles.textFieldDecoration(
                                                    hintText: 'Amount',
                                                  ),
                                                  style: const TextStyle(color: AppColors.theme),
                                                  onChanged: (e) => {establishmentNotifier.value[index].itemAmount = double.parse(e)},
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
                                  ),
                                ),
                              ),
                            ],
                          );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        final status = emptyExpenditureArrayCheck(context: context, data: establishmentNotifier.value)["status"];
                        macaPrint("status$status");
                        if (!status) {
                          isBorderAddedView = !isBorderAddedView;
                        }
                      });
                    },
                    style: AppButtonStyles.elevatedButtonStyle(
                      backgroundColor: AppColors.theme,
                    ),
                    child: Text(
                      isBorderAddedView ? 'Back' : "Next",
                      style: const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                if (isBorderAddedView)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var isValid = emptyAddedBorderArrayCheck(context: context, data: addedBorderListNotifier.value)["status"];
                        if (!isValid) {
                          var expenditure = establishmentCalculation();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RepaintWidget(
                                expenditureDetails: expenditureDetails,
                                totalMeal: expenditure["totalMeal"],
                                userFinalList: expenditure["userFinalList"],
                                establishmentList: expenditure["establishmentList"],
                                totalEstablishment: expenditure["totalEstablishment"],
                                totalMarketing: expenditure["totalMarketing"],
                                totalMember: expenditure["totalMember"],
                              ),
                            ),
                          );
                        }
                      },
                      style: AppButtonStyles.elevatedButtonStyle(
                        backgroundColor: AppColors.theme,
                      ),
                      child: const Text(
                        "Preview",
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                const SizedBox(width: 16), // spacing between buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showBedSelectionModal(context, 2,
                          selectedUsers: addedBorderListNotifier.value.map((item) {
                            return ActiveUser(
                              id: item.id,
                              name: item.name,
                              userBedId: item.userBedId,
                            );
                          }).toList());
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
