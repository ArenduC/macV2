//  "data": [
//       {
//           "name": "TUSHAR KHAN",
//           "user_status": 1,
//           "user_type_id": 2,
//           "user_m_status": "0",
//           "user_id": 17
//       },

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
}
