import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/features/expenditure/helper/add_border_item.dart';
import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/notifiers/added_border_item_notifier.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/colors/app_colors.dart';

class UserListView extends StatefulWidget {
  final List<ActiveUser>? activeUserList;
  final Function(List<ActiveUser>)? onDone;

  const UserListView({
    super.key,
    this.activeUserList,
    this.onDone,
  });

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  List<ActiveUser> userList = [];
  Set<int> selectedUserIds = {};
  List<ActiveUser> selectedUser = [];
  bool allSelect = false;

  @override
  void initState() {
    super.initState();
    // Sample JSON data
    addUserList();
    if (widget.activeUserList != null) {
      selectedUser = List<ActiveUser>.from(widget.activeUserList!);
      selectedUserIds = selectedUser.map((u) => u.id).toSet();
    }
  }

  void toggleSelection(dynamic userId) {
    setState(() {
      if (selectedUserIds.contains(userId.id)) {
        selectedUserIds.remove(userId.id);
        selectedUser.remove(userId);
      } else {
        selectedUserIds.add(userId.id);
        selectedUser.add(userId);
      }

      final addedItem = AddedBorderItem(id: userId.id, name: userId.name, userBedId: userId.userBedId, isGestMeal: false, mealCount: 35, gestMeal: 0, deposit: 0, expenditure: 0);
      addBlankBorderItem(addedItem);
      selectedUser = userList.where((user) => selectedUserIds.contains(user.id)).toList();
      widget.onDone?.call(selectedUser);
    });
    macaPrint(selectedUser.map((u) => u.toString()).join('\n'));
    macaPrint(selectedUserIds);
  }

  addUserList() async {
    var data = await LocalStore().getStore(ListOfStoreKey.activeBorderList);

    if (data is List) {
      setState(() {
        macaPrint("activeUserList${widget.activeUserList}");

        userList = data.map((item) => ActiveUser.fromJson(item as Map<String, dynamic>)).toList();
      });
    } else {
      macaPrint('Expected a List but got: ${data.runtimeType}');
    }
  }

  selectAllList() {
    setState(() {
      allSelect = !allSelect;
      if (allSelect) {
        selectedUser = List<ActiveUser>.from(userList);
        selectedUserIds = selectedUser.map((u) => u.id).toSet();
        final addedItem = userList.map((e) => AddedBorderItem(id: e.id, name: e.name, userBedId: e.userBedId, isGestMeal: false, mealCount: 35, gestMeal: 0, deposit: 0, expenditure: 0)).toList();

        addedBorderListNotifier.value = addedItem;
        widget.onDone?.call(selectedUser);
      } else {
        selectedUser = [];
        selectedUserIds = selectedUser.map((u) => u.id).toSet();
        final addedItem = selectedUser.map((e) => AddedBorderItem(id: e.id, name: e.name, userBedId: e.userBedId, isGestMeal: false, mealCount: 35, gestMeal: 0, deposit: 0, expenditure: 0)).toList();

        addedBorderListNotifier.value = addedItem;
        widget.onDone?.call(selectedUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  Text("Add Border", style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    width: 20,
                  ),
                  if (selectedUser.isNotEmpty)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(color: AppColors.theme, borderRadius: const BorderRadius.all(Radius.circular(5))),
                        ),
                        Text(
                          "${selectedUser.length}",
                          style: TextStyle(color: AppColors.themeWhite, fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                ],
              ),
              GestureDetector(
                onTap: () {
                  selectAllList();
                },
                child: Row(
                  children: [
                    Text("Select All", style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      width: 20,
                    ),
                    if (allSelect)
                      Icon(
                        Icons.check_box_rounded,
                        color: AppColors.theme,
                      )
                    else
                      Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: AppColors.themeLite,
                        weight: 100,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index];
              final isSelected = selectedUserIds.contains(user.id);
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2), // Reduce space inside tile
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                minVerticalPadding: 0,
                leading: CircleAvatar(
                  backgroundColor: AppColors.themeLite,
                  child: Text(
                    user.name[0].toUpperCase(),
                    style: TextStyle(color: AppColors.themeWhite),
                  ),
                ),
                title: Text(user.name, style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w600, fontSize: 15)),
                subtitle: Text("Bed ID: ${user.userBedId}",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.theme,
                    )),
                trailing: isSelected
                    ? Icon(Icons.check_box_rounded, color: AppColors.theme)
                    : Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: AppColors.themeLite,
                      ),
                selected: isSelected,
                focusColor: AppColors.themeLite,
                selectedColor: AppColors.themeLite,
                selectedTileColor: const Color.fromARGB(48, 129, 133, 188),
                onTap: () => toggleSelection(user),
              );
            },
          ),
        ),
      ],
    );
  }
}
