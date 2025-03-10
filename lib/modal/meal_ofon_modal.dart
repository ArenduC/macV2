import 'package:flutter/material.dart';
import 'package:maca/function/app_function.dart';
import 'package:maca/styles/colors/app_colors.dart';

class MealOfOnModal extends StatefulWidget {
  const MealOfOnModal({super.key});

  @override
  State<MealOfOnModal> createState() => _MealOfOnModalState();
}

class _MealOfOnModalState extends State<MealOfOnModal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  Offset _offset = Offset.zero;
  dynamic activeValue = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += details.delta;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (_offset.dx.abs() > 100) {
      if (_offset.dx > 0) {
        setState(() {
          activeValue = 1;
        });
        macaPrint('Swiped right');
      } else {
        setState(() {
          activeValue = 2;
        });
        macaPrint('Swiped left');
      }
    }

    if (_offset.dy.abs() > 100) {
      if (_offset.dy > 0) {
        setState(() {
          activeValue = 3;
        });
        macaPrint('Swiped down');
      } else {
        setState(() {
          activeValue = 4;
        });
        macaPrint('Swiped up');
      }
    }

    setState(() {
      _animation = Tween<Offset>(begin: _offset, end: Offset.zero).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
    });

    _controller.reset();
    _controller.forward();

    _controller.addListener(() {
      setState(() {
        _offset = _animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Meal Off"),
                    SizedBox(
                      height: 100,
                    ),
                    Text("Meal On")
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Color.fromARGB(80, 129, 133, 188), shape: BoxShape.circle),
                  child: GestureDetector(
                    onPanUpdate: _handlePanUpdate,
                    onPanEnd: _handlePanEnd,
                    child: Transform.translate(
                      offset: _offset,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.theme,
                        ),
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
