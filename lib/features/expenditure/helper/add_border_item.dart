import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/notifiers/added_border_item_notifier.dart';

void addBlankBorderItem(AddedBorderItem addedBorderItem) {
  final currentList = [...addedBorderListNotifier.value];
  final index = currentList.indexWhere((item) => item.id == addedBorderItem.id);

  if (index != -1) {
    // Item exists → remove it (toggle off)
    currentList.removeAt(index);
  } else {
    // Item not in list → add it (toggle on)
    currentList
        .add(AddedBorderItem(id: addedBorderItem.id, name: addedBorderItem.name, userBedId: addedBorderItem.userBedId, isGestMeal: false, mealCount: 35, gestMeal: 0, deposit: 0, expenditure: 0));
  }

  addedBorderListNotifier.value = currentList;
}
