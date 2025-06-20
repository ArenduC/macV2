import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper.dart';
import 'package:maca/features/add_electric_bill/model.dart';
import 'package:maca/features/add_electric_bill/view/additional_expend_view.dart';
import 'package:maca/features/add_electric_bill/view/meter_reading_view.dart';
import 'package:maca/features/add_electric_bill/view/user_list_view.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class AddElectricBillView extends StatefulWidget {
  const AddElectricBillView({super.key});

  @override
  State<AddElectricBillView> createState() => _AddElectricBillViewState();
}

class _AddElectricBillViewState extends State<AddElectricBillView> {
  final TextEditingController internetController = TextEditingController();
  final TextEditingController electricBillController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final FocusNode _internetFocusNode = FocusNode();
  final FocusNode _eBillFocusNode = FocusNode();
  final FocusNode _unitFocusNode = FocusNode();

  List<ActiveUser> activeUserList = [];
  List<ActiveUser> selectedUserList = [];
  List<MeterReadingInputModel> meterReadingList = [];
  List<AdditionalExpendModule> additionalExpandList = [];

  bool isValid = false;
  @override
  void initState() {
    super.initState();
    _internetFocusNode.addListener(() {
      setState(() {}); // Rebuild on focus change
    });
    _eBillFocusNode.addListener(() {
      setState(() {}); // Rebuild on focus change
    });
    _unitFocusNode.addListener(() {
      setState(() {}); // Rebuild on focus change
    });
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

    if (data is List) {
      setState(() {
        activeUserList = data.map((item) => ActiveUser.fromJson(item as Map<String, dynamic>)).toList();
      });
    }
  }

  handleGetSelectedUserList() async {}

  void validateFields() {
    setState(() {
      // Check if any of the fields are empty or invalid
      var jsonObject = {"p_electricBill": electricBillController.text, "p_electricUnit": unitController.text, "p_internetBill": internetController.text};
      isValid = isAnyFieldEmpty(jsonObject);
    });
  }

  @override
  void dispose() {
    _internetFocusNode.dispose();
    _eBillFocusNode.dispose();
    _unitFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isInternetFocused = _internetFocusNode.hasFocus;
    final isEBillFocused = _eBillFocusNode.hasFocus;
    final isUnityFocused = _unitFocusNode.hasFocus;

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
              "Add electric bill",
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
                      TextField(
                        focusNode: _internetFocusNode,
                        keyboardType: TextInputType.number,
                        controller: internetController,
                        onChanged: (_) => validateFields(),
                        decoration: AppFormInputStyles.textFieldDecoration(
                          hintText: 'Enter Internet Bill',
                          prefixIcon: Icons.wifi,
                          prefixIconColor: isInternetFocused ? AppColors.theme : AppColors.themeLite,
                        ),
                        style: const TextStyle(color: AppColors.theme),
                      ),
                      const SizedBox(height: 16),

                      // Electric Bill Field
                      TextField(
                        focusNode: _eBillFocusNode,
                        keyboardType: TextInputType.number,
                        controller: electricBillController,
                        onChanged: (_) => validateFields(),
                        decoration: AppFormInputStyles.textFieldDecoration(
                          hintText: 'Enter Electric Bill',
                          prefixIcon: Icons.electric_bolt,
                          prefixIconColor: isEBillFocused ? AppColors.theme : AppColors.themeLite,
                        ),
                        style: const TextStyle(color: AppColors.theme),
                      ),
                      const SizedBox(height: 16),

                      // Unit Field
                      TextField(
                        focusNode: _unitFocusNode,
                        keyboardType: TextInputType.number,
                        controller: unitController,
                        onChanged: (_) => validateFields(),
                        decoration: AppFormInputStyles.textFieldDecoration(
                          hintText: 'Enter Unit Consumed',
                          prefixIcon: Icons.speed,
                          prefixIconColor: isUnityFocused ? AppColors.theme : AppColors.themeLite,
                        ),
                        style: const TextStyle(color: AppColors.theme),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      if (value.isMeterActive) ...[
                        MeterReadingView(
                          onSubmit: (data) {
                            handleGetActiveUserList();
                            setState(() {
                              selectedUserList = data[0].input3;
                              meterReadingList = data;
                            });
                            macaPrint("Received data from meterReadingView: $data");
                            macaPrint("Received data from meterReadingView: $meterReadingList");
                            // Now you can use it however you want.
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (value.isAddition) ...[
                        AdditionalExpendView(
                          onSubmit: (data) {
                            handleGetActiveUserList();
                            setState(() {
                              additionalExpandList = data;
                            });
                            macaPrint("Received data from additionalExpand: $data");
                            macaPrint("Received data from additionalExpand: $additionalExpandList");
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isValid
                        ? () {
                            String internet = internetController.text;
                            String electric = electricBillController.text;
                            String unit = unitController.text;

//var jsonObject = {"p_electricBill": electric, "p_electricUnit": unit, "p_internetBill": internet};

                            // electricBillCreateUpdate(context, jsonObject);
                            // pdfGenerator(billDetails: jsonObject);
                            var electricBillItem = createElectricBillView(
                                internetBill: internet,
                                totalElectricBill: electric,
                                totalElectricUnits: unit,
                                userList: activeUserList,
                                meterReading: meterReadingList,
                                additionalExpendList: additionalExpandList);
                            pdfGenerator(internetBill: internet, totalElectricBill: electric, totalElectricUnits: unit, userList: activeUserList, userFinalList: electricBillItem);
                          }
                        : null,
                    style: AppButtonStyles.elevatedButtonStyle(
                      backgroundColor: isValid ? AppColors.theme : AppColors.themeLite,
                    ),
                    child: const Text(
                      'Preview',
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
