import 'package:maca/features/shift_scheduler/model/shift_schedule.dart';
import 'package:maca/function/app_function.dart';

String shareShift(List<ShiftAssignment> shiftsData) {
  String converter = '''
Generate By MACA
Shift Report 
Month: ${formatCustomDate(DateTime.now())["Month"]}
Manager : 
------------------------------

${shiftsData.map((e) => "${formatCustomDate(e.startDate)["Day"]} ${shiftType(e.startShift)} - "
          "${formatCustomDate(e.endDate)["Day"]} ${shiftType(e.endShift)}:").join("\n")}


''';

  macaPrint("shiftConverter $converter");

  return converter;
}
