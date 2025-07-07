import 'package:flutter/material.dart';
import 'package:maca/styles/colors/app_colors.dart';
import 'package:maca/tabs/more/model.dart';

final List<MoreItemsProperty> moreItems = [
  MoreItemsProperty(
    icon: Icon(
      Icons.settings,
      color: AppColors.theme,
    ),
    title: 'Settings',
    onTap: (context) {},
  ),
  MoreItemsProperty(
    icon: Icon(
      Icons.person,
      color: AppColors.theme,
    ),
    title: 'Profile',
    onTap: (context) {},
  ),
  MoreItemsProperty(
    icon: Icon(
      Icons.pages_rounded,
      color: AppColors.theme,
    ),
    title: 'Electric bill',
    onTap: (context) {
      Navigator.pushNamed(context, '/electricBill');
    },
  ),
  MoreItemsProperty(
    icon: Icon(
      Icons.add_business_rounded,
      color: AppColors.theme,
    ),
    title: 'Expenditure',
    onTap: (context) {
      Navigator.pushNamed(context, '/expenditure');
    },
  ),
  MoreItemsProperty(
    icon: Icon(
      Icons.logout,
      color: AppColors.theme,
    ),
    title: 'Logout',
    onTap: (context) {},
  ),
];
