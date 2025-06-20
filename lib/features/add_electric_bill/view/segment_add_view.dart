import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/controller.dart';
import 'package:maca/features/add_electric_bill/model.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class SegmentAddView extends StatefulWidget {
  const SegmentAddView({super.key});

  @override
  State<SegmentAddView> createState() => _SegmentAddViewState();
}

class _SegmentAddViewState extends State<SegmentAddView> {
  SegmentItemModule segmentModule = SegmentItemModule(
    isMeterActive: false,
    isAddition: false,
  );

  segmentViewUpdate() {}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(10), child: const Text("Electric bill item", style: AppTextStyles.inputLabel)),
          Row(
            // Optional for even spacing
            children: rowItems.map((item) {
              return GestureDetector(
                onTap: item.onTap,
                child: SizedBox(
                  width: 90, // Set fixed width for all items
                  child: AspectRatio(
                    aspectRatio: 1, // Maintain 1:1 ratio
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.themeGray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.icon, color: AppColors.theme),
                          const SizedBox(height: 8),
                          Text(
                            item.label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.theme,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
