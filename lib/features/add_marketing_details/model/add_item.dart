import 'package:flutter/material.dart';

class AddItem {
  int itemTotal;
  AddItem({this.itemTotal = 0});

  AddItem copyWith({int? itemTotal}) {
    return AddItem(itemTotal: itemTotal ?? this.itemTotal);
  }

  @override
  String toString() {
    return 'AddItem(Total item: $itemTotal)';
  }
}

final ValueNotifier<AddItem> addItemNotifier = ValueNotifier(AddItem());
