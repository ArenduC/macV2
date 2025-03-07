class UserDetails {
  String userName;
  String userType;
  int userId;

  UserDetails({
    required this.userName,
    required this.userType,
    required this.userId,
  });

  UserDetails.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        userType = json['userType'],
        userId = json['userId'];
}

class SetUserDetails {
  static UserDetails setUserData({dynamic data}) {
    UserDetails userDetails = UserDetails(
      userName: data["user_name"],
      userType: data["user_type"],
      userId: data["user_id"],
    );
    return userDetails;
  }
}

enum ActionType { add, edit, delete }
