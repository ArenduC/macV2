import 'package:flutter/material.dart';

class MoreItemsProperty {
  final Icon icon;
  final String title;
  final void Function(BuildContext context)? onTap;

  MoreItemsProperty({
    required this.icon,
    required this.title,
    this.onTap,
  });

  // Optional: If you want to serialize this model
  factory MoreItemsProperty.fromJson(Map<String, dynamic> json) {
    return MoreItemsProperty(
      icon: Icon(IconData(json['iconCode'], fontFamily: 'MaterialIcons')),
      title: json['title'],
      // `onTap` cannot be serialized directly
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iconCode': icon.icon!.codePoint,
      'title': title,
    };
  }
}
