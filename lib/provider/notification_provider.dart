import 'package:flutter/foundation.dart';
import 'package:maca/function/app_function.dart';

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
    macaPrint(count);
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class WidgetUpdate with ChangeNotifier, DiagnosticableTreeMixin {
  void increment() {
    macaPrint("itsUpdate");
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
}
