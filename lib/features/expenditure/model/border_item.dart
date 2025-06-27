import 'package:maca/features/expenditure/model/guest_meal_item.dart';
import 'package:maca/function/app_function.dart';

class UserMealData {
  String? userId;
  String? userName;
  double? meal;
  double? deposit;
  double? expenditure;
  bool? gMeal;
  GMealDetails? gMealDetails;

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

class AddedBorderItem {
  final int id;
  final String name;
  final int userBedId;

  AddedBorderItem({
    required this.id,
    required this.name,
    required this.userBedId,
  });

  factory AddedBorderItem.fromJson(Map<String, dynamic> json) {
    return AddedBorderItem(
      id: json['id'],
      name: json['name'],
      userBedId: json['user_bed_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_bed_id': userBedId,
    };
  }

  @override
  String toString() {
    return 'ActiveUser(id: $id, name: $name, userBedId: $userBedId)';
  }
}
