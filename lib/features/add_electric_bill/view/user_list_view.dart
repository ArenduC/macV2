import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maca/features/add_electric_bill/helper.dart';
import 'package:maca/features/add_electric_bill/model.dart';
import 'package:maca/function/app_function.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  List<ActiveUser> userList = [];
  Set<int> selectedUserIds = {};

  @override
  void initState() {
    super.initState();
    // Sample JSON data
    addUserList();
  }

  void toggleSelection(int userId) {
    setState(() {
      if (selectedUserIds.contains(userId)) {
        selectedUserIds.remove(userId);
      } else {
        selectedUserIds.add(userId);
      }
    });

    macaPrint(selectedUserIds);
  }

  addUserList() async {
    var data = await getActiveUserList();
    setState(() {
      userList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height, // or a fixed height
        child: ListView.builder(
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
              onTap: () => toggleSelection(user.id),
            );
          },
        ),
      ),
    );
  }
}
