import 'package:flutter/material.dart';
import 'package:maca/features/electric_bills/electric_bills_helper.dart';
import 'package:maca/features/electric_bills/electric_bills_model.dart';

class ElectricsBillView extends StatefulWidget {
  const ElectricsBillView({super.key});

  @override
  State<ElectricsBillView> createState() => _ElectricsBillViewState();
}

class _ElectricsBillViewState extends State<ElectricsBillView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ElectricBillModel>>(
      future: getMarketingDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data found');
        }

        final bills = snapshot.data!;
        return Expanded(
          child: ListView.builder(
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final bill = bills[index];
              return ListTile(
                title: Text('Electric Bill: ₹${bill.electricBill}'),
                subtitle: Text('Manager ID: ${bill.managerId} • Date: ${bill.createdDate}'),
              );
            },
          ),
        );
      },
    );
  }
}
