// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/add_electric_bill/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/store/local_store.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

Future<dynamic> electricBillCreateUpdate(BuildContext context, dynamic data) async {
  var loginData = await getLocalStorageData("loginDetails");
  var userId = {"p_managerId": loginData[0]["user_id"]};
  dynamic jsonBody = {...userId, ...data};
  macaPrint("jsonData: $jsonBody");
  dynamic response = await ApiService().apiCallService(endpoint: PostUrl().electricBillCreate, method: ApiType().post, body: jsonBody);
  AppFunction().macaApiResponsePrintAndGet(data: response, snackBarView: true, context: context);
}

Future<List<ActiveUser>> getActiveUserList() async {
  dynamic response = await ApiService().apiCallService(endpoint: GetUrl().activeUserList, method: ApiType().get);
  final responseData = AppFunction().macaApiResponsePrintAndGet(data: response)["data"] as List<dynamic>;
  final bills = responseData.reversed.map((e) => ActiveUser.fromJson(e)).toList();
  LocalStore().setStore(ListOfStoreKey.activeBorderList, bills);
  return bills;
}

bool isAnyFieldEmpty(dynamic data) {
  bool isEnable = data.values.any((value) => value == null || value.toString().trim().isEmpty || value == 0);

  return !isEnable;
}

Future<void> pdfGenerator({
  required String internetBill,
  required String totalElectricUnits,
  required String totalElectricBill,
  required List<ActiveUser> userList,
}) async {
  final pdf = generateElectricBillPdf(internetBill: internetBill, totalElectricBill: totalElectricBill, totalElectricUnits: totalElectricUnits, userList: userList);

  // ✅ Get writable directory (Documents folder)
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/example.pdf';

  // ✅ Save the file
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  // ✅ Open the PDF file
  await OpenFilex.open(filePath);
}

final ValueNotifier<SegmentItemModule> segmentNotifier = ValueNotifier(SegmentItemModule());

pw.Document generateElectricBillPdf({
  required String internetBill,
  required String totalElectricUnits,
  required String totalElectricBill,
  required List<ActiveUser> userList,
}) {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
        final internet = double.tryParse(internetBill) ?? 0.0;
        final electric = double.tryParse(totalElectricBill) ?? 0.0;
        final userCount = userList.isNotEmpty ? userList.length : 1;

        final internetPerHead = (internet / userCount).toStringAsFixed(2);
        final electricPerHead = (electric / userCount).toStringAsFixed(2);
        final total = ((internet / userCount) + (electric / userCount)).toStringAsFixed(2);
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // 🔹 Top Info
            pw.Text('Internet Bill: ₹$internetBill', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 5),
            pw.Text('Total Electric Units: $totalElectricUnits', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 5),
            pw.Text('Total Electricity Bill: ₹$totalElectricBill', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),

            // 🔹 Table Header
            pw.Table.fromTextArray(
              headers: ['Name', 'Internet/Head', 'Electric/Head', 'Total'],
              data: userList.map((user) {
                return [
                  user.name,
                  internetPerHead,
                  electricPerHead,
                  total,
                ];
              }).toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.centerLeft,
              cellPadding: const pw.EdgeInsets.all(8),
              border: pw.TableBorder.all(color: PdfColors.black),
            ),
          ],
        );
      },
    ),
  );

  return pdf;
}
