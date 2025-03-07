import 'dart:ui';

import 'package:maca/styles/colors/app_colors.dart';

enum AnimationModel {
  loading,
  success,
  failed,
  none,
  defaultAnimation,
  warning,
}

class AnimationButtonColor {
  static const Color defaultColor = AppColors.defaultColor;
  static const Color loadingColor = AppColors.loadingColor;
  static const Color successColor = AppColors.successColor;
  static const Color failedColor = AppColors.failedColor;
  static const Color warningColor = AppColors.warningColor;
  static const Color noneColor = AppColors.noneColor;
}

class AnimationButtonTextColor {
  static const Color defaultColor = AppColors.themeWhite;
  static const Color loadingColor = AppColors.theme;
  static const Color successColor = AppColors.themeWhite;
  static const Color failedColor = AppColors.themeWhite;
  static const Color warningColor = Color.fromARGB(255, 133, 82, 6);
  static const Color noneColor = AppColors.theme;
}
