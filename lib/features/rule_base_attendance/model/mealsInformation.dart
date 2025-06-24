import 'package:maca/function/app_function.dart';

class MealShiftInfo {
  final String day; // Format: "dd/MM/yyyy"
  final String shift; // "D0" or "N0"

  MealShiftInfo({required this.day, required this.shift});

  factory MealShiftInfo.fromJson(Map<String, dynamic> json) {
    return MealShiftInfo(
      day: json['day'],
      shift: json['shift'],
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'shift': shift,
      };
}

class MealOfSetDetail {
  final MealShiftInfo start;
  final MealShiftInfo end;

  MealOfSetDetail({required this.start, required this.end});

  factory MealOfSetDetail.fromJson(Map<String, dynamic> json) {
    return MealOfSetDetail(
      start: MealShiftInfo.fromJson(json['start']),
      end: MealShiftInfo.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() => {
        'start': start.toJson(),
        'end': end.toJson(),
      };
}

class AbsentUserData {
  final int userId;
  final List<MealOfSetDetail> mealOfSetDetails;

  AbsentUserData({required this.userId, required this.mealOfSetDetails});

  factory AbsentUserData.fromJson(Map<String, dynamic> json) {
    print('Parsing AbsentUserData from: $json');

    final parsed = AbsentUserData(
      userId: json['userId'],
      mealOfSetDetails: (json['mealOfSetDetails'] as List).map((e) => MealOfSetDetail.fromJson(e)).toList(),
    );

    macaPrint('Parsed AbsentUserData: userId=${parsed.userId}, '
        'detailsCount=${parsed.mealOfSetDetails.length}');

    return parsed;
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'userId': userId,
      'mealOfSetDetails': mealOfSetDetails.map((e) => e.toJson()).toList(),
    };
    macaPrint('Serializing AbsentUserData to JSON: $jsonMap');
    return jsonMap;
  }
}
