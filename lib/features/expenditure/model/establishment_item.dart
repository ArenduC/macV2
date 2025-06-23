class EstablishmentItem {
  String? itemName;
  double? itemAmount;

  EstablishmentItem({this.itemAmount, this.itemName});

  @override
  String toString() {
    return 'GMealDetails(veg: $itemName, nonVeg: $itemAmount)';
  }
}
