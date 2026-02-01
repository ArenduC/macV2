import 'package:flutter/material.dart';
import 'package:maca/features/shift_scheduler/helper/shift_schedule_generator.dart';

class ShiftScheduleActionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool disabled;
  final String label;
  const ShiftScheduleActionButton({super.key, required this.onPressed, this.disabled = false, this.label = "Action Button"});

  @override
  State<ShiftScheduleActionButton> createState() => _ShiftScheduleActionButtonState();
}

class _ShiftScheduleActionButtonState extends State<ShiftScheduleActionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: widget.disabled ? null : widget.onPressed, child: Text(widget.label));
  }
}
