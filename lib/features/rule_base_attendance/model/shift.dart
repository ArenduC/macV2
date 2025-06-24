enum ShiftType { Day, Night }

class Shift {
  final DateTime date;
  final ShiftType shift;

  Shift(this.date, this.shift);

  @override
  bool operator ==(Object other) => other is Shift && dateOnly(other.date) == dateOnly(date) && other.shift == shift;

  @override
  int get hashCode => dateOnly(date).hashCode ^ shift.hashCode;

  static DateTime dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
