import 'package:flutter/material.dart';
import 'package:maca/common/common_snack_bar.dart';
import 'package:maca/screen/login_screen.dart';
import 'package:maca/styles/app_style.dart';
import 'package:maca/styles/colors/app_colors.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.themeWhite,
        appBar: AppBar(
          title: const Text('More'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color.fromARGB(0, 40, 46, 137),
                    elevation: 0,
                    content: CommonSnackBar()));
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [profile(context)],
            )));
  }
}

Widget profile(BuildContext context) {
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  return Container(
    decoration: BoxDecoration(
        boxShadow: const [AppBoxShadow.defaultBoxShadow],
        borderRadius: BorderRadius.circular(11),
        color: AppColors.themeWhite),
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(
              Icons.person,
              color: AppColors.theme,
            ),
            SizedBox(
              width: 8,
            ),
            Text("Log out")
          ],
        ),
        GestureDetector(
          onTap: () {
            dialogBuilder(context);
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
