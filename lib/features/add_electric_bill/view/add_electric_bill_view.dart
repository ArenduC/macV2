import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper.dart';
import 'package:maca/features/add_electric_bill/view/user_list_view.dart';
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
  }

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
        title: const Text("Add electric bill details"),
        backgroundColor: AppColors.themeWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
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

            const UserListView(),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isValid
                  ? () {
                      String internet = internetController.text;
                      String electric = electricBillController.text;
                      String unit = unitController.text;

                      var jsonObject = {"p_electricBill": electric, "p_electricUnit": unit, "p_internetBill": internet};

                      electricBillCreateUpdate(context, jsonObject);
                    }
                  : null,
              style: AppButtonStyles.elevatedButtonStyle(backgroundColor: isValid ? AppColors.theme : AppColors.themeLite),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
