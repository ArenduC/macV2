import 'package:maca/features/shift_scheduler/helper/share_shift.dart';
import 'package:maca/features/shift_scheduler/model/shift_schedule.dart';
import 'package:share_plus/share_plus.dart';

void shareShiftSchedule(List<ShiftAssignment> shiftsData) {
  Share.share(shareShift(shiftsData));
}
