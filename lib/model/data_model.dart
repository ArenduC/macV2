class UserData {
  final String name;
  const UserData({required this.name});
}

class ExpenseData {
  final String item;
  final double amount;
  const ExpenseData({required this.item, required this.amount});

  Map<String, dynamic> toJson() {
    return {
      "item": item,
      "amount": amount,
    };
  }
}
