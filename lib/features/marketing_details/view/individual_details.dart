import 'package:flutter/material.dart';
import 'package:maca/features/marketing_details/marketing_details_model.dart';
import 'package:maca/styles/colors/app_colors.dart';

class IndividualDetails extends StatefulWidget {
  final List<ItemData>? individualMarketing;
  const IndividualDetails({super.key, this.individualMarketing});

  @override
  State<IndividualDetails> createState() => _IndividualDetailsState();
}

class _IndividualDetailsState extends State<IndividualDetails> {
  @override
  Widget build(BuildContext context) {
    final itemCount = widget.individualMarketing?.length ?? 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        // Each row height approx ~50px + some padding
        const estimatedItemHeight = 60.0;
        final totalHeight = itemCount * estimatedItemHeight;
        final targetHeight = totalHeight > maxHeight * 0.5 ? maxHeight * 0.5 : totalHeight;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Marketing list",
                        style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    "Item",
                    style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.theme),
                  )),
                  Expanded(child: Text("₹Item Price", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.theme))),
                  Expanded(
                    child: Text("Created Date", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.theme)),
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              color: AppColors.theme,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: targetHeight),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final user = widget.individualMarketing![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(user.item, style: TextStyle(color: AppColors.theme))),
                        Expanded(child: Text("₹${user.price}", style: TextStyle(color: AppColors.theme))),
                        Expanded(
                          child: Text(user.createdDate, textAlign: TextAlign.right, style: TextStyle(color: AppColors.theme)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
