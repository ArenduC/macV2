import 'package:flutter/material.dart';
import 'package:maca/common/loading_component.dart';
import 'package:maca/page/marketing_page.dart';
import 'package:maca/styles/colors/app_colors.dart';

class ShiftScheduleGeneratorView extends StatefulWidget {
  final dynamic shiftAssignment;
  const ShiftScheduleGeneratorView({super.key, this.shiftAssignment = const []});

  @override
  State<ShiftScheduleGeneratorView> createState() => _ShiftScheduleGeneratorViewState();
}

class _ShiftScheduleGeneratorViewState extends State<ShiftScheduleGeneratorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.theme,
                )),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Shift Schedule",
              style: TextStyle(color: AppColors.theme, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.themeWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: widget.shiftAssignment.isEmpty
            ? const LoadingComponent()
            : Column(children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: widget.shiftAssignment.length,
                    itemBuilder: (context, index) {
                      final user = widget.shiftAssignment[index];
                      return Container(
                          // Align text to the left
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                          child: marketingStatusView(user));
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 4,
                    ),
                  ),
                ),
              ]),
      ),
    );
  }
}
