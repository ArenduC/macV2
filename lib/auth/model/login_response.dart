class LoginResponse {
  final bool isSuccess;
  final List<UserData> data;

  LoginResponse({
    required this.isSuccess,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      isSuccess: json['isSuccess'],
      data: (json['data'] as List<dynamic>).map((item) => UserData.fromJson(item)).toList(),
    );
  }
}

class UserData {
  final int userId;
  final String userName;
  final String userType;
  final String userBed;
  final String city;
  final String totalMarketing;

  UserData({
    required this.userId,
    required this.userName,
    required this.userType,
    required this.userBed,
    required this.city,
    required this.totalMarketing,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['user_id'],
      userName: json['user_name'],
      userType: json['user_type'],
      userBed: json['user_bed'],
      city: json['city'],
      totalMarketing: json['total_marketing'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'user_type': userType,
      'user_bed': userBed,
      'city': city,
      'total_marketing': totalMarketing,
    };
  }
}
