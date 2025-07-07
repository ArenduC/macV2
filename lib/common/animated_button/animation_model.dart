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
  static Color defaultColor = AppColors.defaultColor;
  static Color loadingColor = AppColors.loadingColor;
  static Color successColor = AppColors.successColor;
  static Color failedColor = AppColors.failedColor;
  static Color warningColor = AppColors.warningColor;
  static Color noneColor = AppColors.noneColor;
}

class AnimationButtonTextColor {
  static Color defaultColor = AppColors.themeWhite;
  static Color loadingColor = AppColors.theme;
  static Color successColor = const Color.fromARGB(255, 47, 114, 2);
  static Color failedColor = AppColors.themeWhite;
  static Color warningColor = const Color.fromARGB(255, 133, 82, 6);
  static Color noneColor = AppColors.theme;
}
