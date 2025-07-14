import 'dart:math';

List<Map<String, dynamic>> generateShiftsAccurate({
  required int month,
  required int year,
  required int numberOfPeople,
}) {
  final rand = Random();
  final result = <Map<String, dynamic>>[];
  final totalDays = DateTime(year, month + 1, 0).day;

  final baseDays = totalDays ~/ numberOfPeople;
  final extraDays = totalDays % numberOfPeople;

  int currentDay = 1;
  int previousEndShift = 0;

  for (int i = 0; i < numberOfPeople; i++) {
    // Dynamically adjust days to fit exactly till end of month
    int remainingDays = totalDays - currentDay + 1;
    int days = min(baseDays + (i < extraDays ? 1 : 0), remainingDays);

    int startShift = (i == 0) ? 0 : 1 - previousEndShift;
    int startDay = currentDay;

    int endDay = startDay + days - 1;
    if (endDay > totalDays) endDay = totalDays;

    // If this is the last person OR remainingDays <= days, force endDay to month-end
    if (i == numberOfPeople - 1 || endDay == totalDays) {
      endDay = totalDays;
      days = endDay - startDay + 1;
    }

    int endShift;
    if (endDay == totalDays) {
      // If it's the last shift of the month, make sure it ends properly
      endShift = 1;
    } else {
      // Randomize day/night end shift for variation
      endShift = rand.nextBool() ? startShift : 1 - startShift;
    }

    result.add({
      "user_id": "",
      "marketing_user": "Select your shift",
      "startDate": DateTime(year, month, startDay).toIso8601String(),
      "endDate": DateTime(year, month, endDay).toIso8601String(),
      "startShift": startShift,
      "endShift": endShift,
      "status": 0,
      "day": endDay - startDay + 1
    });

    // If we've reached the last day of the month, break
    if (endDay >= totalDays) break;

    // Update currentDay for the next shift
    currentDay = (endShift == 0) ? endDay : endDay + 1;
    previousEndShift = endShift;
  }

  return result;
}
