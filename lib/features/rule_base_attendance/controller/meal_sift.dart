import 'package:intl/intl.dart';
import 'package:maca/features/rule_base_attendance/model/mealsInformation.dart';
import 'package:maca/features/rule_base_attendance/model/shift.dart';

List<Shift> generateAbsentShifts(DateTime startDate, String startShift, DateTime endDate, String endShift) {
  List<Shift> shifts = [];

  final shiftList = ['N0', 'D0'];
  DateTime current = startDate;

  while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
    for (String shiftCode in shiftList) {
      if (current == startDate && shiftCode != startShift) continue;
      if (current == endDate && shiftCode == 'D0' && endShift == 'N0') break;

      shifts.add(Shift(current, shiftCode == 'D0' ? ShiftType.Day : ShiftType.Night));
    }
    current = current.add(const Duration(days: 1));
  }

  return shifts;
}

Map<String, dynamic> calculateTotalMeals({
  required int daysInMonth,
  required int totalUsers,
  required List<AbsentUserData> absentData,
}) {
  // Track how many users are absent per shift
  Map<Shift, int> absentShiftCounts = {};

  for (var user in absentData) {
    for (var period in user.mealOfSetDetails) {
      DateTime start = DateFormat('dd/MM/yyyy').parse(period.start.day);
      DateTime end = DateFormat('dd/MM/yyyy').parse(period.end.day);
      String startShift = period.start.shift;
      String endShift = period.end.shift;

      final userShifts = generateAbsentShifts(start, startShift, end, endShift);
      for (final shift in userShifts) {
        absentShiftCounts.update(shift, (val) => val + 1, ifAbsent: () => 1);
      }
    }
  }

  int totalDayShifts = daysInMonth * totalUsers;
  int totalNightShifts = totalDayShifts;

  int dayAbsences = absentShiftCounts.entries.where((entry) => entry.key.shift == ShiftType.Day).fold(0, (sum, entry) => sum + entry.value);

  int nightAbsences = absentShiftCounts.entries.where((entry) => entry.key.shift == ShiftType.Night).fold(0, (sum, entry) => sum + entry.value);

  int dayMealTaken = totalDayShifts - dayAbsences;
  int nightMealTaken = totalNightShifts - nightAbsences;

  // Current date info
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  ShiftType shiftType = now.hour < 14 ? ShiftType.Day : ShiftType.Night;
  Shift currentShift = Shift(today, shiftType);

  int currentShiftMeal = totalUsers - (absentShiftCounts[currentShift] ?? 0);

  int todayDayMeal = totalUsers - (absentShiftCounts[Shift(today, ShiftType.Day)] ?? 0);
  int todayNightMeal = totalUsers - (absentShiftCounts[Shift(today, ShiftType.Night)] ?? 0);

  return {
    'Day Meals': dayMealTaken,
    'Night Meals': nightMealTaken,
    'Total Meals': dayMealTaken + nightMealTaken,
    'Current Shift Meal': currentShiftMeal,
    'currentDayMealCount': {
      'day': todayDayMeal,
      'night': todayNightMeal,
    }
  };
}
