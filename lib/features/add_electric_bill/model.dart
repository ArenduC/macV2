class ActiveUser {
  final int id;
  final String name;
  final int userBedId;

  ActiveUser({
    required this.id,
    required this.name,
    required this.userBedId,
  });

  factory ActiveUser.fromJson(Map<String, dynamic> json) {
    return ActiveUser(
      id: json['id'],
      name: json['name'],
      userBedId: json['user_bed_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_bed_id': userBedId,
    };
  }
}
