// ignore_for_file: file_names

class MealAbsentDetail {
  final DateTime startDate;
  final String startShift; // 'D0' or 'N0'
  final DateTime endDate;
  final String endShift;

  MealAbsentDetail({
    required this.startDate,
    required this.startShift,
    required this.endDate,
    required this.endShift,
  });

  Map<String, dynamic> toJson() => {
        'start_date': startDate.toIso8601String(),
        'start_shift': startShift,
        'end_date': endDate.toIso8601String(),
        'end_shift': endShift,
      };
}

class MealAbsentHeader {
  final int userId;
  final List<MealAbsentDetail> mealOfSetDetails;

  MealAbsentHeader({required this.userId, required this.mealOfSetDetails});

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'mealOfSetDetails': mealOfSetDetails.map((e) => e.toJson()).toList(),
      };
}
