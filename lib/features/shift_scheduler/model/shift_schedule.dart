class ShiftAssignment {
  final String? userId;
  final String? marketingUser;
  final DateTime startDate;
  final DateTime endDate;
  final int startShift;
  final int endShift;
  final int status;
  final int day;

  ShiftAssignment({
    required this.userId,
    required this.marketingUser,
    required this.startDate,
    required this.endDate,
    required this.startShift,
    required this.endShift,
    required this.status,
    required this.day,
  });

  factory ShiftAssignment.fromJson(Map<String, dynamic> json) {
    return ShiftAssignment(
      userId: json['user_id'],
      marketingUser: json['marketing_user'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      startShift: json['startShift'],
      endShift: json['endShift'],
      status: json['status'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'marketing_user': marketingUser,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'startShift': startShift,
      'endShift': endShift,
      'status': status,
      'day': day,
    };
  }
}
