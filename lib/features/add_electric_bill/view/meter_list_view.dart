import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MeterListView extends StatefulWidget {
  final List<ActiveMeter>? activeMeterList;
  final int? selectedMeterId;
  final Function(List<ActiveMeter>)? onDone;

  const MeterListView({super.key, this.activeMeterList, this.onDone, this.selectedMeterId});

  @override
  State<MeterListView> createState() => _MeterListViewState();
}

class _MeterListViewState extends State<MeterListView> {
  List<ActiveMeter> meterList = [];
  Set<int> selectedMeterIds = {};
  List<ActiveMeter> selectedMeter = [];
  bool allSelect = false;

  @override
  void initState() {
    super.initState();
    // Sample JSON data
    addUserList();
    macaPrint("selectedMeterIdsAtFirst${widget.selectedMeterId}");
    if (widget.selectedMeterId != null) {
      macaPrint("selectedMeterIds${widget.selectedMeterId}");
      selectedMeterIds.add(widget.selectedMeterId ?? 0);
    }
  }

  void toggleSelection(dynamic userId) {
    setState(() {
      // If already selected, deselect
      if (selectedMeterIds.contains(userId.id)) {
        selectedMeterIds.clear();
        selectedMeter.clear();
      } else {
        selectedMeterIds
          ..clear()
          ..add(userId.id);
        selectedMeter
          ..clear()
          ..add(userId);
      }

      // Update selection from meterList (optional if above is enough)
      selectedMeter = meterList.where((user) => selectedMeterIds.contains(user.id)).toList();

      // Callback
      widget.onDone?.call(selectedMeter);
    });

    macaPrint(selectedMeter.map((u) => u.toString()).join('\n'));
    macaPrint(selectedMeterIds);
  }

  addUserList() async {
    var data = await LocalStore().getStore(ListOfStoreKey.activeMeterList);
    if (data is List) {
      setState(() {
        meterList = data.map((item) => ActiveMeter.fromJson(item as Map<String, dynamic>)).toList();
      });
    } else {
      macaPrint('Expected a List but got: ${data.runtimeType}');
    }
  }

  selectAllList() {
    setState(() {
      allSelect = !allSelect;
      if (allSelect) {
        selectedMeter = List<ActiveMeter>.from(meterList);
        selectedMeterIds = selectedMeter.map((u) => u.id).toSet();
        widget.onDone?.call(selectedMeter);
      } else {
        selectedMeter = [];
        selectedMeterIds = selectedMeter.map((u) => u.id).toSet();
        widget.onDone?.call(selectedMeter);
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
                  const Text("Add Meter", style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    width: 20,
                  ),
                  if (selectedMeter.isNotEmpty)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          height: 20,
                          width: 50,
                          decoration: const BoxDecoration(color: AppColors.theme, borderRadius: BorderRadius.all(Radius.circular(5))),
                        ),
                        Text(
                          "M${selectedMeterIds.first}",
                          style: const TextStyle(color: AppColors.themeWhite, fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                ],
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: meterList.length,
            itemBuilder: (context, index) {
              final user = meterList[index];
              final isSelected = selectedMeterIds.contains(user.id);
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2), // Reduce space inside tile
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                minVerticalPadding: 0,
                leading: const CircleAvatar(
                    backgroundColor: AppColors.themeLite,
                    child: Icon(
                      Icons.gas_meter_rounded,
                      color: AppColors.themeWhite,
                    )),
                title: Text(user.meterName, style: const TextStyle(color: AppColors.theme, fontWeight: FontWeight.w600, fontSize: 15)),
                subtitle: Text("Meter ID: ${user.id}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.theme,
                    )),
                trailing: isSelected
                    ? const Icon(Icons.check_box_rounded, color: AppColors.theme)
                    : const Icon(
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
