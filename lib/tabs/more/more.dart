import 'package:flutter/material.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/tabs/more/controller.dart';
import 'package:maca/tabs/more/model.dart';

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
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.theme,
          title: Text(
            'More',
            style: TextStyle(color: AppColors.themeWhite),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemCount: moreItems.length,
            separatorBuilder: (_, __) => const Divider(
              height: 15,
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
          backgroundColor: AppColors.themeWhite,
          title: Text(
            'Logout Warning',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.theme),
          ),
          content: Text(
            "You will be logged out from the application shortly.",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.theme),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: AppButtonStyles.elevatedButtonStyle(backgroundColor: AppColors.theme),
                  child: Text(
                    'No',
                    style: TextStyle(color: AppColors.themeWhite),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: AppButtonStyles.outlinedButtonStyle(),
                  child: const Text('Yes'),
                  onPressed: () {
                    LocalStore().deleteStore(ListOfStoreKey.loginDetails);
                    LocalStore().setStore(ListOfStoreKey.loginStatus, false);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  return GestureDetector(
    onTap: () {
      moreItems.title == "Logout" ? dialogBuilder(context) : moreItems.onTap?.call(context);
    },
    child: Container(
      decoration: BoxDecoration(boxShadow: const [AppBoxShadow.defaultBoxShadow], borderRadius: BorderRadius.circular(11), color: AppColors.themeWhite),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              moreItems.icon,
              const SizedBox(
                width: 8,
              ),
              Text(
                moreItems.title,
                style: TextStyle(color: AppColors.theme),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color: AppColors.theme,
          ),
        ],
      ),
    ),
  );
}
