import 'package:flutter/material.dart';
import 'package:maca/styles/colors/app_colors.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: AppColors.ongoing), child: const Text('Default Page')),
    ]);
  }
}
