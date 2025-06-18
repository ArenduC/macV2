import 'package:flutter/material.dart';
import 'package:maca/tabs/more/model.dart';

final List<MoreItemsProperty> moreItems = [
  MoreItemsProperty(
    icon: const Icon(Icons.settings),
    title: 'Settings',
    onTap: (context) {},
  ),
  MoreItemsProperty(
    icon: const Icon(Icons.person),
    title: 'Profile',
    onTap: (context) {},
  ),
  MoreItemsProperty(
    icon: const Icon(Icons.pages_rounded),
    title: 'Electric bill',
    onTap: (context) {
      Navigator.pushNamed(context, '/electricBill');
    },
  ),
  MoreItemsProperty(
    icon: const Icon(Icons.logout),
    title: 'Logout',
    onTap: (context) {},
  ),
];
