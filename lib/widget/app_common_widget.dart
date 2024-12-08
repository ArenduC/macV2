import 'package:flutter/material.dart';
import 'package:maca/styles/colors/app_colors.dart';

//this is for API success screen view
class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle,
          size: 50,
          color: AppColors.themeLite,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Successfully item added",
          style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.theme),
        )
      ],
    ));
    ;
  }
}

//this for switch

class SwitchView extends StatefulWidget {
  const SwitchView({super.key});

  @override
  State<SwitchView> createState() => _SwitchViewState();
}

class _SwitchViewState extends State<SwitchView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
