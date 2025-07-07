import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maca/common/animated_button/animation_model.dart';
import 'package:maca/features/add_marketing_details/helper/add_expense.dart';
import 'package:maca/features/add_marketing_details/model/data_model.dart';
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
      if (widget.statusCode == 100) {
        setState(() {
          selected = true;
        });
      }
    }
  }

  colorPicker(dynamic statusCode) {
    switch (statusCode) {
      case 200:
        return {
          buttonColor = AnimationButtonColor.successColor,
          textColor = AnimationButtonTextColor.successColor,
          buttonText = "Successfully Added",
          icon = Icon(Icons.check_circle, color: AnimationButtonTextColor.successColor)
        };
      case 400:
        return {buttonColor = AnimationButtonColor.failedColor};
      case 500:
        return {
          buttonColor = AnimationButtonColor.warningColor,
          textColor = AnimationButtonTextColor.warningColor,
          buttonText = "All fields are required",
          icon = Icon(
            Icons.warning_rounded,
            color: AnimationButtonTextColor.warningColor,
          )
        };
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
                  tween: ColorTween(
                    begin: textColor ?? Colors.blue, // ✅ Provide a default color
                    end: textColor ?? Colors.blue, // ✅ Provide a default color
                  ),
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  builder: (context, color, child) {
                    return widget.statusCode == 300
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: color ?? Colors.blue, // ✅ Use the animated color or fallback
                              strokeWidth: 2.0,
                            ),
                          )
                        : icon ?? const SizedBox(); // ✅ Ensure `icon` is non-null
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
      return const CircularProgressIndicator();
    case AnimationModel.success:
      return Icon(
        Icons.check_circle,
        color: AppColors.themeLite,
      );
    case AnimationModel.failed:
      return Icon(
        Icons.error,
        color: AppColors.themeLite,
      );
    default:
      return const Text("buttonText");
  }
}
