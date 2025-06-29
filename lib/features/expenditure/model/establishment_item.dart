class EstablishmentItem {
  String? itemName;
  double? itemAmount;

  EstablishmentItem({this.itemAmount, this.itemName});

  factory EstablishmentItem.fromJson(Map<String, dynamic> json) {
    return EstablishmentItem(
      itemName: json["itemName"],
      itemAmount: json["itemAmount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemAmount': itemAmount,
    };
  }

  @override
  String toString() {
    return 'GMealDetails(veg: $itemName, nonVeg: $itemAmount)';
  }
}
