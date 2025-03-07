import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maca/common/animated_button/animation_model.dart';
import 'package:maca/helper/add_expense.dart';
import 'package:maca/model/data_model.dart';
import 'package:maca/styles/colors/app_colors.dart';

// ignore: must_be_immutable
class AnimationButton extends StatefulWidget {
  String buttonText;
  Future? Function() onPressed;
  bool? isLoading;
  int? statusCode;
  List<ExpenseData>? data;
  AnimationButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading,
    this.statusCode,
    this.data,
  });

  @override
  State<AnimationButton> createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State<AnimationButton> {
  bool selected = true;

  Timer? timer;
  String buttonText = "Add Expense";
  Color? buttonColor = AnimationButtonColor.defaultColor;
  Color? textColor = AnimationButtonTextColor.defaultColor;
  int? code;
  Icon? icon;

  @override
  void initState() {
    super.initState();
  }

  statusController() {
    setState(() {
      print("widget.data ${widget.data}");
      print(" emptyArrayCheck ${emptyArrayCheck(context: context, data: widget.data ?? [])["code"]}");
      code = emptyArrayCheck(context: context, data: widget.data ?? [])["code"];
      widget.statusCode = code;
    });
    if (code != 300) {
      timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
        if (selected == false) {
          setState(() {
            colorPicker(100);
            selected = true;
          });
          t.cancel();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant AnimationButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.statusCode != oldWidget.statusCode) {
      colorPicker(widget.statusCode);
    }
  }

  colorPicker(dynamic statusCode) {
    switch (statusCode) {
      case 200:
        return {buttonColor = AnimationButtonColor.successColor, textColor = AnimationButtonTextColor.successColor, buttonText = "Successfully Added", icon = const Icon(Icons.check_circle)};
      case 400:
        return {buttonColor = AnimationButtonColor.failedColor};
      case 500:
        return {buttonColor = AnimationButtonColor.warningColor, textColor = AnimationButtonTextColor.warningColor, buttonText = "All fields are required", icon = const Icon(Icons.warning_rounded)};
      case 100:
        return {buttonColor = AnimationButtonColor.defaultColor, textColor = AnimationButtonTextColor.defaultColor, buttonText = "Add Expense", icon = const Icon(Icons.add)};
      case 300:
        return {buttonColor = AnimationButtonColor.defaultColor, textColor = AnimationButtonTextColor.defaultColor, buttonText = "Loading..."};
      default:
        return buttonColor = AnimationButtonColor.defaultColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !selected
          ? null
          : () {
              widget.onPressed();
              statusController();
              colorPicker(widget.statusCode);
              setState(() {
                selected = false;
              });
            },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.center,
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? buttonColor : buttonColor,
        ),
        child: SizedBox(
          child: Stack(alignment: Alignment.center, children: [
            AnimatedPositioned(
              width: 200.0,
              height: 50.0,
              right: selected ? MediaQuery.of(context).size.width / 2 - 120 : MediaQuery.of(context).size.width - 200,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Center(
                  child: AnimatedDefaultTextStyle(
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                style: TextStyle(
                  color: selected ? textColor : textColor,
                ),
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                ),
              )),
            ),
            AnimatedPositioned(
              width: 100.0,
              height: 50.0,
              left: selected ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width - 100,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Center(
                child: TweenAnimationBuilder<Color?>(
                  tween: ColorTween(begin: textColor, end: textColor),
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  builder: (context, color, child) {
                    print(widget.statusCode);
                    return widget.statusCode == 300
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: textColor,
                              strokeWidth: 2.0,
                            ),
                          )
                        : icon!;
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

@override
Widget buttonState({required AnimationModel model, required String buttonText}) {
  switch (model) {
    case AnimationModel.defaultAnimation:
      return Text(buttonText);
    case AnimationModel.loading:
      return CircularProgressIndicator();
    case AnimationModel.success:
      return const Icon(
        Icons.check_circle,
        color: AppColors.themeLite,
      );
    case AnimationModel.failed:
      return const Icon(
        Icons.error,
        color: AppColors.themeLite,
      );
    default:
      return const Text("buttonText");
  }
}
