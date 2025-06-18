import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/store/local_store.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index];
              final isSelected = selectedUserIds.contains(user.id);
              return ListTile(
                leading: CircleAvatar(child: Text(user.name[0])),
                title: Text(user.name),
                subtitle: Text("Bed ID: ${user.userBedId}"),
                trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : const Icon(Icons.circle_outlined),
                selected: isSelected,
                onTap: () => toggleSelection(user),
              );
            },
          ),
        ),
      ],
    );
  }
}
