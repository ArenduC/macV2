import 'package:flutter/material.dart';
import 'package:maca/common/loading_component.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/helper/maca_global_helper.dart';
import 'package:maca/model/data_model.dart';
import 'package:maca/models/global_model.dart';
import 'package:maca/store/local_store.dart';
import 'package:maca/styles/colors/app_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  dynamic loginDetails;
  @override
  void initState() {
    getLoginDetails();
    super.initState();
  }

  getLoginDetails() async {
    loginDetails = await LocalStore().getStore(ListOfStoreKey.loginDetails);
    setState(() {
      loginDetails = loginDetails;
    });
    macaPrint("loginData,$loginDetails");
  }

  @override
  Widget build(BuildContext context) {
    return loginDetails == null
        ? Container()
        : Container(
            margin: const EdgeInsets.only(right: 16),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.logoDep,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrinks column to fit content
              children: [
                Container(
                  padding: EdgeInsets.all(8), // Remove extra padding
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.themeWhite,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Ensures button size is based on text
                      minimumSize: Size(0, 0), // Avoids extra space
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes default tap area padding
                    ),
                    onPressed: () {},
                    child: Text("${firstAlphabetExtractAndCapitalize(loginDetails?[0]["user_name"])}", style: TextStyle(fontSize: 15, color: AppColors.theme)),
                  ),
                ),
              ],
            ),
          );
  }
}
