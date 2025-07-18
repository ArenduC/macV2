import 'package:flutter/material.dart';
import 'package:maca/styles/colors/app_colors.dart';

class AppTextStyles {
  // Define your text styles here
  static TextStyle headline1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.header1,
  );

  static TextStyle headline2 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    color: AppColors.theme,
  );

  static TextStyle inputLabel = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.theme,
  );

  static TextStyle cardLabel1 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    color: AppColors.theme,
  );

  static TextStyle header10 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors.theme,
  );
  static TextStyle header11 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: AppColors.theme,
  );
  static TextStyle header11B = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    color: AppColors.theme,
  );
  static TextStyle header16 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
    color: AppColors.theme,
  );
  static TextStyle header17 = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w300,
    color: AppColors.theme,
  );
  static TextStyle header18 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.theme,
  );

  static TextStyle bodyText = TextStyle(
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
  static TextStyle linkText = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    color: AppColors.themeLite,
  );
  static TextStyle indicatorTextStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.theme);

  static TextStyle cardHeaderLabelStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: AppColors.theme);
  static TextStyle cardPillTextStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: AppColors.theme);
  static TextStyle cardHeader2LabelStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: AppColors.theme);
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
      hintStyle: TextStyle(
        color: AppColors.themeLite,
        fontSize: 13.0,
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.themeLite) : null, // Optional prefix icon
      suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: AppColors.themeLite) : null, // Optional suffix icon
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        borderSide: BorderSide(
          color: AppColors.themeLite,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
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
      contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
    );
  }
}

class AppFormInputStyles {
  // Common InputDecoration for text fields
  static InputDecoration textFieldDecoration({
    required String hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Color? prefixIconColor,
    Color? suffixIconColor,
    VoidCallback? onSuffixIconTap,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: AppColors.themeLite,
        fontSize: 13.0,
      ),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: prefixIconColor) : null, // Optional prefix icon
      suffixIcon: suffixIcon != null
          ? GestureDetector(
              onTap: onSuffixIconTap,
              child: Icon(suffixIcon, color: suffixIconColor),
            )
          : null,
// Optional suffix icon
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        borderSide: BorderSide(
          color: AppColors.themeLite,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: AppColors.theme,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: AppColors.themeLite,
          width: 1.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
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
      hintStyle: TextStyle(
        color: AppColors.themeLite,
        fontSize: 13.0,
      ),
      filled: true,
      fillColor: AppColors.themeGray,

      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.theme) : null, // Optional prefix icon
      suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: AppColors.theme) : null, // Optional suffix icon
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        borderSide: BorderSide(
          color: AppColors.themeGray,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: AppColors.themeGray,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: AppColors.themeWhite,
          width: 1.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
    );
  }
}

class AppButtonStyles {
  // Custom ElevatedButton style
  static ButtonStyle elevatedButtonStyle({
    Color? backgroundColor,
    double borderRadius = 10.0,
    Color? borderColor,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 12.0),
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.themeLite,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 4.0, // Optional: Set elevation for shadow effect
    );
  }

  // Another example for outlined buttons
  static ButtonStyle outlinedButtonStyle({
    Color? borderColor,
    double borderRadius = 10.0,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 12.0),
  }) {
    return OutlinedButton.styleFrom(
      backgroundColor: AppColors.themeWhite,
      side: BorderSide(color: borderColor ?? AppColors.themeLite, width: 1.0),
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class AppBoxShadow {
  static const BoxShadow defaultBoxShadow = BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.13), offset: Offset(0, 4), blurRadius: 5, spreadRadius: 0);
}
