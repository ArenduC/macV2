class ElectricBillModel {
  final int id;
  final int managerId;
  final int electricBill;
  final int electricUnit;
  final int internetBill;
  final DateTime createdDate;

  ElectricBillModel({
    required this.id,
    required this.managerId,
    required this.electricBill,
    required this.electricUnit,
    required this.internetBill,
    required this.createdDate,
  });

  // Factory constructor to create object from JSON
  factory ElectricBillModel.fromJson(Map<String, dynamic> json) {
    return ElectricBillModel(
      id: json['id'],
      managerId: json['manager_id'],
      electricBill: json['electric_bill'],
      electricUnit: json['electric_unit'],
      internetBill: json['internet_bill'],
      createdDate: DateTime.parse(json['created_date']),
    );
  }

  // Convert object back to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manager_id': managerId,
      'electric_bill': electricBill,
      'electric_unit': electricUnit,
      'internet_bill': internetBill,
      'created_date': createdDate.toIso8601String(),
    };
  }
}
