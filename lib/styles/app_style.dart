import 'package:flutter/material.dart';
import 'package:maca/styles/colors/app_colors.dart';

class AppTextStyles {
  // Define your text styles here
  static const TextStyle headline1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.header1,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    color: AppColors.theme,
  );

  static const TextStyle inputLabel = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.theme,
  );

  static const TextStyle cardLabel1 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    color: AppColors.theme,
  );

  static const TextStyle header10 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors.theme,
  );
  static const TextStyle header11 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: AppColors.theme,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    color: AppColors.header1,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle hintText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );
  static const TextStyle linkText = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    color: AppColors.themeLite,
  );
  static const TextStyle indicatorTextStyle = TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.theme);

  static const TextStyle cardHeaderLabelStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w300, color: AppColors.theme);
  static const TextStyle cardPillTextStyle = TextStyle(
      fontSize: 10, fontWeight: FontWeight.w300, color: AppColors.theme);
  static const TextStyle cardHeader2LabelStyle = TextStyle(
      fontSize: 25, fontWeight: FontWeight.w700, color: AppColors.theme);
}

class AppInputStyles {
  // Common InputDecoration for text fields
  static InputDecoration textFieldDecoration({
    required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.themeLite,
        fontSize: 13.0,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: AppColors.themeLite)
          : null, // Optional prefix icon
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: AppColors.themeLite)
          : null, // Optional suffix icon
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        borderSide: const BorderSide(
          color: AppColors.themeLite,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: AppColors.header1,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
    );
  }
}

class AppDateStyles {
  static InputDecoration textFieldDecoration({
    required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.themeLite,
        fontSize: 13.0,
      ),
      filled: true,
      fillColor: AppColors.themeGray,

      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: AppColors.theme)
          : null, // Optional prefix icon
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: AppColors.theme)
          : null, // Optional suffix icon
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        borderSide: const BorderSide(
          color: AppColors.themeGray,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: AppColors.themeGray,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: AppColors.themeWhite,
          width: 1.0,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
    );
  }
}

class AppButtonStyles {
  // Custom ElevatedButton style
  static ButtonStyle elevatedButtonStyle({
    Color backgroundColor = AppColors.themeLite,
    double borderRadius = 10.0,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 12.0),
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 4.0, // Optional: Set elevation for shadow effect
    );
  }

  // Another example for outlined buttons
  static ButtonStyle outlinedButtonStyle({
    Color borderColor = AppColors.themeLite,
    double borderRadius = 10.0,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 16.0),
  }) {
    return OutlinedButton.styleFrom(
      side: BorderSide(color: borderColor, width: 2.0),
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class AppBoxShadow {
  static const BoxShadow defaultBoxShadow = BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.13),
      offset: Offset(0, 4),
      blurRadius: 5,
      spreadRadius: 0);
}
