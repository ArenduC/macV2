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

Future<List<ActiveMeter>> getActiveMeterList() async {
  dynamic response = await ApiService().apiCallService(endpoint: GetUrl().activeMeterList, method: ApiType().get);
  final responseData = AppFunction().macaApiResponsePrintAndGet(data: response)["data"] as List<dynamic>;
  final meterList = responseData.reversed.map((e) => ActiveMeter.fromJson(e)).toList();
  LocalStore().setStore(ListOfStoreKey.activeMeterList, meterList);
  return meterList;
}

Future<List<MeterReading>> getMonthlyReadingList() async {
  dynamic response = await ApiService().apiCallService(endpoint: GetUrl().getMonthlyMeterReadings, method: ApiType().get);
  final responseData = AppFunction().macaApiResponsePrintAndGet(data: response)["data"] as List<dynamic>;
  final meterReadingList = responseData.reversed.map((e) => MeterReading.fromJson(e)).toList();
  LocalStore().setStore(ListOfStoreKey.getMonthlyMeterReadings, meterReadingList);
  return meterReadingList;
}

bool isAnyFieldEmpty(dynamic data) {
  bool isEnable = data.values.any((value) => value == null || value.toString().trim().isEmpty || value == 0);

  return !isEnable;
}

List<UserElectricBillItem> createElectricBillView({
  required String internetBill,
  required String totalElectricUnits,
  required String totalElectricBill,
  required List<ActiveUser> userList,
  final List<MeterReadingInputModel>? meterReading,
  final List<AdditionalExpendModule>? additionalExpendList,
}) {
  macaPrint(totalElectricUnits);
  macaPrint(totalElectricBill);
  macaPrint(userList);
  macaPrint(internetBill);
  macaPrint(meterReading);
  macaPrint(additionalExpendList);

  List<UserElectricBillItem> steepingList = userList.map((element) {
    var getDetails = genericElectricAmount(
        electricBill: totalElectricBill, userId: element.id, electricUnit: totalElectricUnits, userList: userList, meterReading: meterReading, additionalItem: additionalExpendList);

    return UserElectricBillItem(
      userName: element.name,
      internet: (int.parse(internetBill) / userList.length).roundToDouble(),
      unit: getDetails["unit"] ?? 0.0,
      meterName: getDetails["meterId"] ?? "",
      gElectricBill: getDetails["genericChargePerHead"] ?? 0.0,
      mElectricBill: getDetails["chargePerHead"] ?? 0.0,
      oExpend: getDetails["additionalCharge"] ?? 0.0,
      total:
          ((int.parse(internetBill) / userList.length) + (getDetails["additionalCharge"] ?? 0.0) + (getDetails["genericChargePerHead"] ?? 0.0) + (getDetails["chargePerHead"] ?? 0.0)).roundToDouble(),
    );
  }).toList();

  macaPrint("steepingList$steepingList");

  List<UserElectricBillItem> finalList = [UserElectricBillItem(userName: "", internet: 00.0, unit: 0.0, gElectricBill: 0.0, mElectricBill: 0.0, oExpend: 0.0, total: 0.0)];
  return steepingList;
}

dynamic genericElectricAmount(
    {List<ActiveUser>? userList, List<MeterReadingInputModel>? meterReading, List<AdditionalExpendModule>? additionalItem, String? electricBill, String? electricUnit, dynamic userId}) {
  var getUnit = int.parse(electricBill!) / int.parse(electricUnit!);
  var genericChargePerHead = meterReading!.isEmpty ? (int.parse(electricBill) / userList!.length) : 0;
  var eachCharge;
  var totalMeterUnit = 0;
  var meterUnit;
  var meterId;
  var jsonObject;
  var noOfUserInEachMeter;

  var meterWiseUserList;

  if (userList!.isNotEmpty) {
    if (meterReading.isNotEmpty) {
      for (var meter in meterReading) {
        totalMeterUnit += int.parse(meter.input2);
      }

      genericChargePerHead = (int.parse(electricBill) - (totalMeterUnit * getUnit)) / userList.length;

      bool foundInMeter = false;

      for (var element in meterReading) {
        meterUnit = int.parse(element.input2);
        meterId = element.input1;
        eachCharge = (meterUnit / element.input3.length) * getUnit;

        for (var mElement in element.input3) {
          if (mElement.id == userId) {
            jsonObject = {
              "userName": mElement.name,
              "chargePerHead": eachCharge,
              "genericChargePerHead": genericChargePerHead,
              "meterId": element.input1,
              "meterUnit": meterUnit / element.input3.length,
            };
            foundInMeter = true;
            break;
          }
        }

        if (foundInMeter) break;
      }

      if (!foundInMeter) {
        final fallback = userList.firstWhere((el) => el.id == userId);
        if (fallback != null) {
          jsonObject = {
            "userName": fallback.name,
            "chargePerHead": 0.0,
            "genericChargePerHead": genericChargePerHead,
            "meterId": "",
            "meterUnit": 0.0,
          };
        }
      }
    } else {
      final fallback = userList.firstWhere(
        (el) => el.id == userId,
      );
      if (fallback != null) {
        jsonObject = {
          "userName": fallback.name,
          "chargePerHead": 0.0,
          "genericChargePerHead": genericChargePerHead,
          "meterId": "",
          "meterUnit": 0.0,
        };
      }
    }

    // Add additional charges
    if (additionalItem!.isNotEmpty) {
      for (var ad in additionalItem) {
        var itemTotal = int.parse(ad.input2);

        if (ad.input3.any((adE) => adE.id == userId)) {
          jsonObject = {
            ...jsonObject,
            "additionalCharge": itemTotal / ad.input3.length,
          };
        }
      }
    }
  }

  return jsonObject;
}

Future<void> pdfGenerator({
  required String internetBill,
  required String totalElectricUnits,
  required String totalElectricBill,
  required List<ActiveUser> userList,
  required List<UserElectricBillItem> userFinalList,
}) async {
  final pdf = generateElectricBillPdf(internetBill: internetBill, totalElectricBill: totalElectricBill, totalElectricUnits: totalElectricUnits, userList: userList, userFinalList: userFinalList);

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
  required List<UserElectricBillItem> userFinalList,
}) {
  final pdf = pw.Document();
  macaPrint("userFinalist$userFinalList");
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
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
              headers: ['Name', 'Internet', 'GElectric', 'Meter Id', 'Unit', 'MElectric', 'Extra Charge', 'Total'],
              data: userFinalList.map((user) {
                return [user.userName, user.internet, user.gElectricBill, user.meterName, user.mElectricBill, user.unit, user.oExpend, user.total];
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
