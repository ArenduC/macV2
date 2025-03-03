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
}
