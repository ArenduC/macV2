import 'package:flutter/material.dart';
import 'dart:math';

import 'package:maca/styles/colors/app_colors.dart';

class ThreeDotHarmonicLoading extends StatefulWidget {
  const ThreeDotHarmonicLoading({Key? key}) : super(key: key);

  @override
  _ThreeDotHarmonicLoadingState createState() => _ThreeDotHarmonicLoadingState();
}

class _ThreeDotHarmonicLoadingState extends State<ThreeDotHarmonicLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(); // Loop animation
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 60,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              double waveHeight = sin((_controller.value * 2 * pi) + (index * pi / 2)) * 7;
              return Transform.translate(
                offset: Offset(0, -waveHeight), // Moves up and down
                child: _buildDot(),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        color: AppColors.themeLite,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
