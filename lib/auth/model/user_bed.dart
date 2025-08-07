class UserBed {
  final String userBed;
  final int id;

  UserBed({
    required this.userBed,
    required this.id,
  });

  factory UserBed.fromJson(Map<String, dynamic> json) {
    return UserBed(
      userBed: json['user_bed'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_bed': userBed,
      'id': id,
    };
  }
}
