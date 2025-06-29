import 'package:maca/features/expenditure/model/establishment_item.dart';
import 'package:maca/features/expenditure/notifiers/added_border_item_notifier.dart';

void addBlankEstablishment(EstablishmentItem addEstablishmentItem) {
  final currentList = [...establishmentNotifier.value];
  final index = currentList.indexWhere((item) => item == addEstablishmentItem);

  if (index != -1) {
    // Item exists → remove it (toggle off)
    currentList.removeAt(index);
  } else {
    // Item not in list → add it (toggle on)
    currentList.add(EstablishmentItem(itemAmount: addEstablishmentItem.itemAmount, itemName: addEstablishmentItem.itemName));
  }

  establishmentNotifier.value = currentList;
}
