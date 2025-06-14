import 'package:flutter/material.dart';
import 'package:maca/tabs/more/controller.dart';
import 'package:maca/tabs/more/model.dart';

import 'package:open_filex/open_filex.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:maca/screen/login_screen.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:path_provider/path_provider.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  Future<void> pdfGenerator() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Text('Hello World', style: const pw.TextStyle(fontSize: 40)),
              pw.Text('This is a PDF test.', style: const pw.TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );

    // ✅ Get writable directory (Documents folder)
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/example.pdf';

    // ✅ Save the file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // ✅ Open the PDF file
    await OpenFilex.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.themeWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.theme,
          title: const Text(
            'More',
            style: TextStyle(color: AppColors.themeWhite),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
            itemCount: moreItems.length,
            separatorBuilder: (_, __) => const Divider(
              height: 10,
              thickness: 0,
              color: Colors.transparent,
            ),
            itemBuilder: (context, index) {
              final item = moreItems[index];
              return profile(context, item);
            },
          ),
        ));
  }
}

Widget profile(BuildContext context, MoreItemsProperty moreItems) {
  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  return Container(
    decoration: BoxDecoration(boxShadow: const [AppBoxShadow.defaultBoxShadow], borderRadius: BorderRadius.circular(11), color: AppColors.themeWhite),
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            moreItems.icon,
            const SizedBox(
              width: 8,
            ),
            Text(moreItems.title)
          ],
        ),
        GestureDetector(
          onTap: () {
            moreItems.title == "Logout" ? dialogBuilder(context) : moreItems.onTap?.call(context);
          },
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
        )
      ],
    ),
  );
}
