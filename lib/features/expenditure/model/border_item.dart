import 'package:maca/features/expenditure/model/guest_meal_item.dart';
import 'package:maca/function/app_function.dart';

class UserMealData {
  final String? userId;
  final String? userName;
  final double? meal;
  final double? deposit;
  final double? expenditure;
  final bool? gMeal;
  final GMealDetails? gMealDetails;

  UserMealData({
    this.userId,
    this.userName,
    this.meal,
    this.deposit,
    this.expenditure,
    this.gMeal,
    this.gMealDetails,
  });

  factory UserMealData.fromJson(Map<String, dynamic> json) {
    final instance = UserMealData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      meal: (json['meal'] as num).toDouble(),
      deposit: (json['deposit'] as num).toDouble(),
      expenditure: (json['expenditure'] as num).toDouble(),
      gMeal: json['gMeal'] as bool,
      gMealDetails: GMealDetails.fromJson(json['gMealDetails']),
    );
    macaPrint('UserMealData created: $instance');
    return instance;
  }

  Map<String, dynamic> toJson() {
    final map = {
      'userId': userId,
      'userName': userName,
      'meal': meal,
      'deposit': deposit,
      'expenditure': expenditure,
      'gMeal': gMeal,
      'gMealDetails': gMealDetails!.toJson(),
    };
    macaPrint('UserMealData toJson: $map');
    return map;
  }

  @override
  String toString() {
    return 'UserMealData(userId: $userId, userName: $userName, meal: $meal, deposit: $deposit, expenditure: $expenditure, gMeal: $gMeal, gMealDetails: $gMealDetails)';
  }
}
