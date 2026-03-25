// {"targetUserId":14,"newStatus":1,"newType":1, "newMStatus": "1", "adminUserId":24}

class UpdateUserDetailsParameter {
  final int targetUserId;
  final int newStatus;
  final int newType;
  final String newMStatus;
  final int? adminUserId;

  UpdateUserDetailsParameter({
    required this.targetUserId,
    required this.newStatus,
    required this.newType,
    required this.newMStatus,
    this.adminUserId,
  });

  Map<String, dynamic> toJson() {
    return {
      "targetUserId": targetUserId,
      "newStatus": newStatus,
      "newType": newType,
      "newMStatus": newMStatus,
      "adminUserId": adminUserId,
    };
  }
}
