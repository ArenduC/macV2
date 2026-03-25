//  "data": [
//       {
//           "name": "TUSHAR KHAN",
//           "user_status": 1,
//           "user_type_id": 2,
//           "user_m_status": "0",
//           "user_id": 17
//       },

import 'package:maca/features/admin/data/models/user_status_type_marketing_enum.dart';

class UserDetails {
  final String name;
  final int userStatus;
  final int userTypeId;
  final String userMarketingStatus;
  final int userId;

  UserDetails({
    required this.name,
    required this.userStatus,
    required this.userTypeId,
    required this.userMarketingStatus,
    required this.userId,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(name: json["name"], userStatus: json["user_status"], userTypeId: json["user_type_id"], userId: json["user_id"], userMarketingStatus: json["user_m_status"]);
  }

  UserDetails copyWith({
    String? name,
    int? userId,
    String? userMarketingStatus,
    int? userStatus,
    int? userTypeId,
  }) {
    return UserDetails(
      userId: userId ?? this.userId,
      userMarketingStatus: userMarketingStatus ?? this.userMarketingStatus,
      userStatus: userStatus ?? this.userStatus,
      userTypeId: userTypeId ?? this.userTypeId,
      name: name ?? this.name,
    );
  }

  UserStatus get statusEnum {
    return userStatus == 1 ? UserStatus.active : UserStatus.inActive;
  }

  UserType get typeEnum {
    switch (userMarketingStatus) {
      case "0":
        return UserType.border;
      case "1":
        return UserType.manager;
      case "2":
        return UserType.admin;
      default:
        return UserType.border;
    }
  }
}
