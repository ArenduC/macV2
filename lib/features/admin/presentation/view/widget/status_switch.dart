import 'package:flutter/material.dart';
import 'package:maca/features/admin/data/models/user_details_model.dart';
import 'package:maca/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:provider/provider.dart';

class StatusSwitch extends StatelessWidget {
  final UserDetails userDetails;
  const StatusSwitch({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userDetails.userStatus == 0
          ? null
          : () => context.read<AdminBloc>().add(
                UserStatusUpdate(userDetails.userId, userDetails.userStatus, userDetails.userTypeId, userDetails.userMarketingStatus, context: context),
              ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(3),
          width: 50,
          height: 30,
          decoration: BoxDecoration(
              color: userDetails.userMarketingStatus == "0"
                  ? userDetails.userStatus == 0
                      ? AppColors.themeLite.withAlpha(20)
                      : AppColors.completed
                  : AppColors.theme,
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(20))),
          child: Stack(alignment: Alignment.center, children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              right: userDetails.userMarketingStatus == "0" ? 22 : 0,
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: userDetails.userMarketingStatus == "0"
                        ? userDetails.userStatus == 0
                            ? AppColors.themeGray
                            : AppColors.themeLite
                        : AppColors.themeWhite),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
