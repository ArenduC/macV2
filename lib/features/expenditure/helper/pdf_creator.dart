import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maca/function/app_function.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

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
