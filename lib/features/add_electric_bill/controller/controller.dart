import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/helper/helper.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/function/app_function.dart';

List<RowItemModel> rowItems = [
  RowItemModel(
    icon: Icons.gas_meter_rounded,
    label: "Meeter",
    isActive: true,
    onTap: () {
      segmentNotifier.value = segmentNotifier.value.copyWith(isMeterActive: !segmentNotifier.value.isMeterActive);
      macaPrint("Meeter Reading");
    },
  ),
  RowItemModel(
    icon: Icons.add_box_rounded,
    label: "Addition",
    isActive: false,
    onTap: () {
      segmentNotifier.value = segmentNotifier.value.copyWith(isAddition: !segmentNotifier.value.isAddition);
      macaPrint("Additional Item");
    },
  ),
];
