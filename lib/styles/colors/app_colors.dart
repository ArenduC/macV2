// import 'dart:ui';

// class AppColors {
//   static const bool isDark = true;
//   static const Color theme = isDark ? Color.fromRGBO(10, 12, 36, 1): Color.fromRGBO(40, 47, 137, 1) ;
//   static const Color themeLite = Color.fromRGBO(129, 133, 188, 1);
//   static const Color header1 = Color.fromRGBO(255, 255, 255, 1);
//   static const Color textHint = Color.fromRGBO(129, 133, 188, 1);
//   static const Color themeWhite = Color.fromRGBO(255, 255, 255, 1);
//   static const Color themeGray = Color.fromRGBO(211, 211, 211, 1);
//   static const Color upcoming = Color.fromRGBO(255, 231, 195, 1);
//   static const Color idle = Color.fromRGBO(255, 195, 195, 1);
//   static const Color ongoing = Color.fromRGBO(184, 247, 141, 1);
//   static const Color completed = Color.fromRGBO(217, 217, 217, 1);
//   static const Color logoDep = Color.fromARGB(255, 92, 229, 0);

//   static const Color defaultColor = Color.fromRGBO(40, 47, 137, 1);
//   static const Color loadingColor = Color.fromRGBO(184, 247, 141, 1);
//   static const Color successColor = Color.fromRGBO(92, 229, 0, 1);
//   static const Color errorColor = Color.fromRGBO(229, 34, 0, 1);
//   static const Color failedColor = Color.fromRGBO(255, 195, 195, 1);
//   static const Color warningColor = Color.fromRGBO(255, 231, 195, 1);
//   static const Color noneColor = Color.fromRGBO(217, 217, 217, 1);

//   AppColors(da);
// }

import 'dart:ui';

class AppColors {
  static const bool isDark = false;

  static Color get theme => isDark ? const Color.fromRGBO(10, 12, 36, 1) : const Color.fromRGBO(40, 47, 137, 1);

  static Color get backGround => isDark ? const Color.fromARGB(255, 4, 4, 20) : const Color.fromRGBO(255, 255, 255, 1);

  static Color get themeLite => isDark ? const Color.fromRGBO(129, 133, 188, 1) : const Color.fromRGBO(129, 133, 188, 1);

  static Color get header1 => isDark ? const Color.fromRGBO(235, 235, 245, 1) : const Color.fromRGBO(0, 0, 0, 1);

  static Color get textHint => isDark ? const Color.fromRGBO(140, 140, 150, 1) : const Color.fromRGBO(129, 133, 188, 1);

  static Color get themeWhite => isDark ? const Color.fromARGB(255, 5, 5, 27) : const Color.fromRGBO(255, 255, 255, 1);

  static Color get themeGray => isDark ? const Color.fromRGBO(70, 70, 80, 1) : const Color.fromRGBO(211, 211, 211, 1);

  static Color get upcoming => isDark ? const Color.fromRGBO(255, 210, 150, 1) : const Color.fromRGBO(255, 231, 195, 1);

  static Color get idle => isDark ? const Color.fromRGBO(180, 100, 100, 1) : const Color.fromRGBO(255, 195, 195, 1);

  static Color get ongoing => isDark ? const Color.fromRGBO(130, 200, 100, 1) : const Color.fromRGBO(184, 247, 141, 1);

  static Color get completed => isDark ? const Color.fromRGBO(90, 90, 100, 1) : const Color.fromRGBO(217, 217, 217, 1);

  static const Color logoDep = Color.fromARGB(255, 92, 229, 0);

  static Color get defaultColor => isDark ? const Color.fromRGBO(20, 30, 100, 1) : const Color.fromRGBO(40, 47, 137, 1);

  static Color get loadingColor => isDark ? const Color.fromRGBO(130, 200, 100, 1) : const Color.fromRGBO(184, 247, 141, 1);

  static Color get successColor => isDark ? const Color.fromRGBO(82, 209, 10, 1) : const Color.fromRGBO(92, 229, 0, 1);

  static Color get errorColor => isDark ? const Color.fromRGBO(200, 50, 50, 1) : const Color.fromRGBO(229, 34, 0, 1);

  static Color get failedColor => isDark ? const Color.fromRGBO(150, 70, 70, 1) : const Color.fromRGBO(255, 195, 195, 1);

  static Color get warningColor => isDark ? const Color.fromRGBO(255, 180, 100, 1) : const Color.fromRGBO(255, 231, 195, 1);

  static Color get noneColor => isDark ? const Color.fromRGBO(90, 90, 100, 1) : const Color.fromRGBO(217, 217, 217, 1);
}
