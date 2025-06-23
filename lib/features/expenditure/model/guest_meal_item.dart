import 'package:maca/function/app_function.dart';

class GMealDetails {
  final int gMealVegCount;
  final int gMealNonVegCount;

  GMealDetails({
    required this.gMealVegCount,
    required this.gMealNonVegCount,
  });

  factory GMealDetails.fromJson(Map<String, dynamic> json) {
    final instance = GMealDetails(
      gMealVegCount: json['gMealVegCount'] as int,
      gMealNonVegCount: json['gMealNonVegCount'] as int,
    );
    macaPrint('GMealDetails created: $instance');
    return instance;
  }

  Map<String, dynamic> toJson() {
    final map = {
      'gMealVegCount': gMealVegCount,
      'gMealNonVegCount': gMealNonVegCount,
    };
    macaPrint('GMealDetails toJson: $map');
    return map;
  }

  @override
  String toString() {
    return 'GMealDetails(veg: $gMealVegCount, nonVeg: $gMealNonVegCount)';
  }
}
