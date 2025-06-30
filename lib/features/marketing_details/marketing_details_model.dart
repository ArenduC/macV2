class IndividualMarketingDetails {
  final int userId;
  final String user;
  final double totalAmount;

  IndividualMarketingDetails({required this.userId, required this.user, required this.totalAmount});

  factory IndividualMarketingDetails.fromJson(Map<String, dynamic> json) {
    return IndividualMarketingDetails(
      userId: json['userId'],
      user: json['user'],
      totalAmount: json['totalAmount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'user': user,
      'totalAmount': totalAmount,
    };
  }

  @override
  String toString() {
    return 'MonthData(userId: $userId, user: $user,totalAmount :$totalAmount  ';
  }
}

class MonthData {
  final String month;
  final List<IndividualMarketingDetails> data;

  MonthData({required this.month, required this.data});

  factory MonthData.fromJson(Map<String, dynamic> json) {
    return MonthData(
      month: json['month'],
      data: (json['data'] as List).map((e) => IndividualMarketingDetails.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'MonthData(month: $month, data: $data, ';
  }
}

class MonthlyData {
  final String month;
  final String monthYear;
  final List<UserData> userData;

  MonthlyData({
    required this.month,
    required this.monthYear,
    required this.userData,
  });

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      month: json['month'].trim(),
      monthYear: json['month_year'],
      userData: List<UserData>.from(
        json['user_data'].map((x) => UserData.fromJson(x)),
      ),
    );
  }

  @override
  String toString() {
    return 'Month: $month ($monthYear)\n${userData.map((e) => e.toString()).join('\n')}';
  }
}

class UserData {
  final String user;
  final int userId;
  final List<ItemData> data;

  UserData({
    required this.user,
    required this.userId,
    required this.data,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: json['user'],
      userId: json['userId'],
      data: List<ItemData>.from(
        json['data'].map((x) => ItemData.fromJson(x)),
      ),
    );
  }

  @override
  String toString() {
    return '  User: $user (ID: $userId)\n${data.map((e) => e.toString()).join('\n')}';
  }
}

class ItemData {
  final String createdDate;
  final String item;
  final int price;

  ItemData({
    required this.createdDate,
    required this.item,
    required this.price,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      createdDate: json['created_date'],
      item: json['item'].trim(),
      price: json['price'],
    );
  }
  @override
  String toString() {
    return '    - $createdDate | $item | ₹$price';
  }
}
