import 'package:flutter/material.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/colors/app_colors.dart';

class PreviousMeterReadingView extends StatefulWidget {
  final int? selectedMeterId;
  const PreviousMeterReadingView({super.key, this.selectedMeterId});

  @override
  State<PreviousMeterReadingView> createState() => _PreviousMeterReadingViewState();
}

class _PreviousMeterReadingViewState extends State<PreviousMeterReadingView> {
  List<MeterReading> meterReadingList = [];
  List<MeterReading> selectedMeterDetails = [];

  @override
  void initState() {
    super.initState();
    // Sample JSON data
    getMeterReading();
  }

  getMeterReading() async {
    var data = await LocalStore().getStore(ListOfStoreKey.getMonthlyMeterReadings);

    if (data is List) {
      setState(() {
        meterReadingList = data.map((item) => MeterReading.fromJson(item as Map<String, dynamic>)).toList();
        if (widget.selectedMeterId != null) {
          setState(() {
            selectedMeterDetails = meterReadingList.where((m) => m.meterId == widget.selectedMeterId).toList();
          });
          macaPrint("selectedMeterDetails$selectedMeterDetails");
          // Make it a list
        }
      });
      macaPrint('Expected a List but got: $meterReadingList');
    } else {
      macaPrint('Expected a List but got: $meterReadingList');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Meter Reading", style: TextStyle(color: AppColors.theme, fontWeight: FontWeight.w600)),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        selectedMeterDetails.isNotEmpty
            ? Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedMeterDetails[0].readings.length,
                  itemBuilder: (context, index) {
                    final user = selectedMeterDetails[0].readings.reversed.toList()[index];
                    macaPrint("user$user");
                    return ListTile(
                      textColor: AppColors.theme,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2), // Reduce space inside tile
                      visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
                      minVerticalPadding: 0,
                      leading: CircleAvatar(
                        backgroundColor: AppColors.themeLite,
                        child: Text(
                          user.month[0].toUpperCase(),
                          style: const TextStyle(color: AppColors.themeWhite),
                        ),
                      ),
                      title: Text("${formatCustomDate(user.date)["Month"]}", style: const TextStyle(color: AppColors.theme, fontWeight: FontWeight.w600, fontSize: 15)),
                      subtitle: Text("${formatCustomDate(user.date)["Year"]}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.theme,
                          )),

                      trailing: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "${user.reading}",
                              style: const TextStyle(fontSize: 15),
                            ),
                            const Text(
                              "Meter reading",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),

                      focusColor: AppColors.themeLite,
                      selectedColor: AppColors.themeLite,
                      selectedTileColor: const Color.fromARGB(48, 129, 133, 188),
                    );
                  },
                ),
              )
            : const Text("Please wait")
      ],
    );
  }
}
