import 'package:flutter/material.dart';

class LoadingComponent extends StatefulWidget {
  const LoadingComponent({super.key});

  @override
  State<LoadingComponent> createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text("Loading"),
    );
  }
}
