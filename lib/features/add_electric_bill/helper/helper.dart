// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maca/connection/api_connection.dart';
import 'package:maca/data/app_data.dart';
import 'package:maca/features/add_electric_bill/model/model.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/service/api_service.dart';
import 'package:maca/store/local_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

Future<dynamic> electricBillCreateUpdate(BuildContext context, dynamic data) async {
  var loginData = await getLocalStorageData("loginDetails");
  var userId = {"p_managerId": loginData[0]["user_id"]};
  dynamic jsonBody = {...userId, ...data};
  macaPrint("jsonData: $jsonBody");
  dynamic response = await ApiService().apiCallService(endpoint: PostUrl().electricBillCreate, method: ApiType().post, body: jsonBody);
  AppFunction().macaApiResponsePrintAndGet(data: response, snackBarView: true, context: context);
}

Future<dynamic> addMeterReading(BuildContext context, dynamic data) async {
  dynamic jsonBody = data;
  macaPrint("jsonData: $jsonBody");
  dynamic response = await ApiService().apiCallService(endpoint: PostUrl().addMeterReading, method: ApiType().post, body: jsonBody);
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
  final meterList = responseData.map((e) => ActiveMeter.fromJson(e)).toList();
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
  final List<MeterReading>? monthlyMeterReadingList,
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
        electricBill: totalElectricBill,
        userId: element.id,
        electricUnit: totalElectricUnits,
        userList: userList,
        meterReading: meterReading,
        additionalItem: additionalExpendList,
        monthlyMeterReadingList: monthlyMeterReadingList);
    return UserElectricBillItem(
      userName: element.name,
      internet: (int.parse(internetBill) / userList.length).roundToDouble(),
      unit: (getDetails["meterUnit"] ?? 0.0).roundToDouble(),
      meterName: getDetails["meterId"] ?? "",
      gElectricBill: (getDetails["genericChargePerHead"] ?? 0.0).roundToDouble(),
      mElectricBill: (getDetails["chargePerHead"] ?? 0.0).roundToDouble(),
      oExpend: (getDetails["additionalCharge"] ?? 0.0).roundToDouble(),
      total:
          ((int.parse(internetBill) / userList.length) + (getDetails["additionalCharge"] ?? 0.0) + (getDetails["genericChargePerHead"] ?? 0.0) + (getDetails["chargePerHead"] ?? 0.0)).roundToDouble(),
    );
  }).toList();
  return steepingList;
}

dynamic genericElectricAmount({
  List<ActiveUser>? userList,
  List<MeterReadingInputModel>? meterReading,
  List<AdditionalExpendModule>? additionalItem,
  String? electricBill,
  String? electricUnit,
  dynamic userId,
  List<MeterReading>? monthlyMeterReadingList,
}) {
  var getUnit = int.parse(electricBill!) / int.parse(electricUnit!);
  var genericChargePerHead = meterReading!.isEmpty ? (int.parse(electricBill) / userList!.length) : 0;
  var eachCharge = 0.0;
  var totalMeterUnit = 0;
  var meterUnit = 0;
  var jsonObject = {};
  List<MeterReading> selectedMeterDetails = [];
  if (userList!.isNotEmpty) {
    if (meterReading.isNotEmpty) {
      for (var meter in meterReading) {
        selectedMeterDetails = monthlyMeterReadingList!.where((m) => m.meterId == int.parse(meter.input1)).toList();
        totalMeterUnit += selectedMeterDetails.isNotEmpty ? int.parse(meter.input2) - selectedMeterDetails[0].readings.reversed.toList()[0].reading : int.parse(meter.input2);
      }
      genericChargePerHead = (int.parse(electricBill) - (totalMeterUnit * getUnit)) / userList.length;

      bool foundInMeter = false;

      for (var element in meterReading) {
        selectedMeterDetails = monthlyMeterReadingList!.where((m) => m.meterId == int.parse(element.input1)).toList();

        meterUnit = selectedMeterDetails.isNotEmpty ? int.parse(element.input2) - selectedMeterDetails[0].readings.reversed.toList()[0].reading : int.parse(element.input2);
        eachCharge = (meterUnit / element.input3.length) * getUnit;
        for (var mElement in element.input3) {
          if (mElement.id == userId) {
            jsonObject = {
              "userName": mElement.name,
              "chargePerHead": eachCharge,
              "genericChargePerHead": genericChargePerHead,
              "meterId": element.input1,
              "meterUnit": meterUnit / (element.input3.length).roundToDouble(),
            };
            foundInMeter = true;
            break;
          }
        }
        if (foundInMeter) break;
      }
      if (!foundInMeter) {
        final fallback = userList.firstWhere((el) => el.id == userId);
        jsonObject = {
          "userName": fallback.name,
          "chargePerHead": 0.0,
          "genericChargePerHead": genericChargePerHead,
          "meterId": "",
          "meterUnit": 0.0,
        };
      }
    } else {
      final fallback = userList.firstWhere(
        (el) => el.id == userId,
      );
      jsonObject = {
        "userName": fallback.name,
        "chargePerHead": 0.0,
        "genericChargePerHead": genericChargePerHead,
        "meterId": "",
        "meterUnit": 0.0,
      };
    }

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

final ValueNotifier<SegmentItemModule> segmentNotifier = ValueNotifier(SegmentItemModule());

Future<Uint8List> captureWidgetImage(GlobalKey key) async {
  await Future.delayed(const Duration(milliseconds: 100));
  final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
  if (boundary == null) throw Exception("Render boundary not found");
  final image = await boundary.toImage(pixelRatio: 5);
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

Future<void> generatePdfFromWidget(GlobalKey key) async {
  try {
    final imageBytes = await captureWidgetImage(key);
    final pdf = pw.Document();
    final pwImage = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Center(child: pw.Image(pwImage)),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/flutter_widget_invoice.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    // await OpenFilex.open(filePath);

    await file.writeAsBytes(await pdf.save());

    /// Now share it
    await Share.shareXFiles(
      [XFile(filePath)],
      text: 'Here is your invoice 📄',
      subject: 'PDF Invoice',
    );
  } catch (e) {
    macaPrint("Error generating PDF and sharing: $e");
  }
}
