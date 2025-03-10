import 'package:flutter/material.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MColumnGraph extends StatefulWidget {
  final dynamic data;
  const MColumnGraph({super.key, required this.data});

  @override
  State<MColumnGraph> createState() => _MColumnGraphState();
}

class _MColumnGraphState extends State<MColumnGraph> {
  List<Map<String, dynamic>> columnData = [
    {"value": 20, "key": "Ja"},
    {"value": 30, "key": "Fe"},
    {"value": 10, "key": "Ma"},
    {"value": 20, "key": "Ap"},
    {"value": 20, "key": "My"},
    {"value": 50, "key": "Ju"},
    {"value": 20, "key": "Ji"},
    {"value": 30, "key": "Ag"},
    {"value": 44, "key": "Se"},
    {"value": 22, "key": "Oc"},
    {"value": 17, "key": "No"},
    {"value": 20, "key": "De"},
  ];
  late List<int> values;
  late int maxValue;
  double maxHeight = 200.0;

  @override
  void initState() {
    createGraphView();
    super.initState();
  }

  void createGraphView() {
    setState(() {
      values = columnData.map((e) => e["value"] as int).toList();
      maxValue = values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : 1;
      if (maxValue == 0) {
        maxValue = 1;
      }
      maxHeight = 150.0;
    });
  }

// Extract the 'value' field from the data

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(boxShadow: [AppBoxShadow.defaultBoxShadow], color: AppColors.themeWhite, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Stack(children: [
        AnimatedContainer(
          duration: const Duration(microseconds: 800),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: columnData.map<Widget>((data) {
                  double height = ((data["value"] / maxValue) * maxHeight);
                  return AnimatedContainer(
                    duration: const Duration(microseconds: 800),
                    padding: const EdgeInsets.all(2), // Fixed width for each container
                    height: height,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      color: AppColors.themeGray,
                    ),
                    // You can vary colors if needed
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: AppColors.themeLite, shape: BoxShape.circle),
                      child: Text(
                        ((data["value"] / 100)).toStringAsFixed(1),
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Container(
                height: 5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.themeGray),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: columnData.map<Widget>((data) {
                  return AnimatedContainer(
                    duration: const Duration(microseconds: 800),
                    padding: const EdgeInsets.only(left: 8, right: 8), // Fixed width for each container
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    // You can vary colors if needed
                    alignment: Alignment.topCenter,
                    child: Text(
                      data["key"],
                      style: const TextStyle(color: AppColors.themeLite, fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
