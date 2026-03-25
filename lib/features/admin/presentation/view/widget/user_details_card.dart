import 'package:flutter/material.dart';
import 'package:maca/features/admin/data/models/user_details_model.dart';
import 'package:maca/features/admin/presentation/view/widget/status_switch.dart';
import 'package:maca/styles/colors/app_colors.dart';

class UserDetailsCard extends StatelessWidget {
  final UserDetails userDetails;
  const UserDetailsCard({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userDetails.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: userDetails.userStatus == 1 ? AppColors.theme : AppColors.completed,
                    ),
                  ),
                  Text(userDetails.typeEnum.name, style: TextStyle(fontSize: 10, color: userDetails.userStatus == 1 ? AppColors.theme : AppColors.completed)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.all(Radius.circular(20)),
                    color: userDetails.userStatus == 1 ? AppColors.successColor.withAlpha(50) : AppColors.idle.withAlpha(50),
                  ),
                  child: Text(userDetails.statusEnum.name,
                      style: TextStyle(
                        fontSize: 10,
                        color: userDetails.userStatus == 1 ? AppColors.successColor : AppColors.idle,
                      )),
                ),
              ],
            ),
          ),
          StatusSwitch(
            userDetails: userDetails,
          )
        ],
      ),
    );
  }
}
