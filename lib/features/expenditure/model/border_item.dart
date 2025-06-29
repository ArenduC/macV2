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

class ExpendBorderItem {
  final int id;
  final String name;
  final int userBedId;
  bool isGestMeal;
  int mealCount;
  int deposit;
  int expenditure;
  int gestMeal;
  int totalExpend;
  int balance;

  ExpendBorderItem(
      {required this.id,
      required this.name,
      required this.userBedId,
      required this.isGestMeal,
      required this.mealCount,
      required this.deposit,
      required this.expenditure,
      required this.gestMeal,
      required this.balance,
      required this.totalExpend});

  factory ExpendBorderItem.fromJson(Map<String, dynamic> json) {
    return ExpendBorderItem(
      id: json['id'],
      name: json['name'],
      userBedId: json['user_bed_id'],
      isGestMeal: json['isGestMeal'],
      mealCount: json['mealCount'],
      deposit: json['deposit'],
      expenditure: json['expenditure'],
      gestMeal: json['gestMeal'],
      balance: json['balance'],
      totalExpend: json['totalExpend'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_bed_id': userBedId,
      'isGestMeal': isGestMeal,
      'mealCount': mealCount,
      'deposit': deposit,
      'expenditure': expenditure,
      'gestMeal': gestMeal,
      'balance': balance,
      'totalExpend': totalExpend
    };
  }

  @override
  String toString() {
    return 'ExpendBorderItem(id: $id, name: $name, userBedId: $userBedId, isGestMeal: $isGestMeal, mealCount: $mealCount, deposit: $deposit, expenditure: $expenditure, gestMeal: $gestMeal, balance:  $balance, totalExpend: $totalExpend';
  }
}

class AddedBorderItem {
  final int id;
  final String name;
  final int userBedId;
  bool isGestMeal;
  int mealCount;
  int deposit;
  int expenditure;
  int gestMeal;

  AddedBorderItem(
      {required this.id, required this.name, required this.userBedId, required this.isGestMeal, required this.mealCount, required this.deposit, required this.expenditure, required this.gestMeal});

  factory AddedBorderItem.fromJson(Map<String, dynamic> json) {
    return AddedBorderItem(
      id: json['id'],
      name: json['name'],
      userBedId: json['user_bed_id'],
      isGestMeal: json['isGestMeal'],
      mealCount: json['mealCount'],
      deposit: json['deposit'],
      expenditure: json['expenditure'],
      gestMeal: json['gestMeal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'user_bed_id': userBedId, 'isGestMeal': isGestMeal, 'mealCount': mealCount, 'deposit': deposit, 'expenditure': expenditure, 'gestMeal': gestMeal};
  }

  @override
  String toString() {
    return 'ActiveUser(id: $id, name: $name, userBedId: $userBedId, isGestMeal: $isGestMeal, mealCount: $mealCount, deposit: $deposit, expenditure: $expenditure, gestMeal: $gestMeal';
  }
}
