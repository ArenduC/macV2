import 'package:flutter/material.dart';

class ActiveUser {
  final int id;
  final String name;
  final int userBedId;

  ActiveUser({
    required this.id,
    required this.name,
    required this.userBedId,
  });

  factory ActiveUser.fromJson(Map<String, dynamic> json) {
    return ActiveUser(
      id: json['id'],
      name: json['name'],
      userBedId: json['user_bed_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_bed_id': userBedId,
    };
  }

  @override
  String toString() {
    return 'ActiveUser(id: $id, name: $name, userBedId: $userBedId)';
  }
}

class ActiveMeter {
  final int id;
  final String meterName;

  ActiveMeter({
    required this.id,
    required this.meterName,
  });

  factory ActiveMeter.fromJson(Map<String, dynamic> json) {
    return ActiveMeter(
      id: json['meter_id'], // ✅ match key
      meterName: json['meter_name'], // ✅ match key
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meter_id': id,
      'meter_name': meterName,
    };
  }

  @override
  String toString() {
    return 'ActiveUser(id: $id, name: $meterName)';
  }
}

class RowItemModel {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  RowItemModel({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });
}

class MeterReadingInputModel {
  String input1;
  String input2;
  List<ActiveUser> input3;

  MeterReadingInputModel({this.input1 = '', this.input2 = '', this.input3 = const []});

  @override
  String toString() {
    return 'MeterReadingInputModel(input1: $input1, input2: $input2, input3: $input3)';
  }
}

class AdditionalExpendModule {
  String input1;
  String input2;
  List<ActiveUser> input3;

  AdditionalExpendModule({this.input1 = '', this.input2 = '', this.input3 = const []});

  @override
  String toString() {
    return 'AdditionalExpendModule(input1: $input1, input2: $input2, input3: $input3)';
  }
}

class SegmentItemModule {
  bool isMeterActive;
  bool isAddition;

  SegmentItemModule({this.isAddition = false, this.isMeterActive = false});

  SegmentItemModule copyWith({
    bool? isMeterActive,
    bool? isAddition,
  }) {
    return SegmentItemModule(
      isMeterActive: isMeterActive ?? this.isMeterActive,
      isAddition: isAddition ?? this.isAddition,
    );
  }

  @override
  String toString() {
    return 'SegmentItemModule(isMeterActive: $isMeterActive, isAddition: $isAddition)';
  }
}

class MeterReading {
  final int meterId;
  final List<MonthlyReading> readings;

  MeterReading({
    required this.meterId,
    required this.readings,
  });

  factory MeterReading.fromJson(Map<String, dynamic> json) {
    return MeterReading(
      meterId: json['meter_id'],
      readings: (json['readings'] as List).map((e) => MonthlyReading.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'meter_id': meterId,
        'readings': readings.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'MeterReading(meterId: $meterId, readings: [\n  ${readings.join(',\n  ')}\n])';
  }
}

class MonthlyReading {
  final String month;
  final DateTime date;
  final int reading;

  MonthlyReading({
    required this.month,
    required this.date,
    required this.reading,
  });

  factory MonthlyReading.fromJson(Map<String, dynamic> json) {
    return MonthlyReading(
      month: json['month'],
      date: DateTime.parse(json['date']),
      reading: json['reading'],
    );
  }

  Map<String, dynamic> toJson() => {
        'month': month,
        'date': date.toIso8601String(),
        'reading': reading,
      };

  @override
  String toString() {
    return 'MonthlyReading(month: $month, date: $date, reading: $reading)';
  }
}

class UserElectricBillItem {
  final String userName;
  final double internet;
  final double unit;
  final double gElectricBill;
  final String? meterName;
  final double mElectricBill;
  final double oExpend;
  final double total;

  UserElectricBillItem({
    required this.userName,
    required this.internet,
    required this.unit,
    required this.gElectricBill,
    this.meterName,
    required this.mElectricBill,
    required this.oExpend,
    required this.total,
  });

  factory UserElectricBillItem.fromJson(Map<String, dynamic> json) {
    return UserElectricBillItem(
      userName: (json["userName"]),
      internet: (json['internet'] ?? 0).toDouble(),
      unit: (json['unit'] ?? 0).toDouble(),
      gElectricBill: (json['gElectricBill'] ?? 0).toDouble(),
      meterName: (json["meterName"]),
      mElectricBill: (json['mElectricBill'] ?? 0).toDouble(),
      oExpend: (json['oExpend'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'internet': internet,
      'unit': unit,
      'gElectricBill': gElectricBill,
      "meterName": meterName,
      'mElectricBill': mElectricBill,
      'oExpend': oExpend,
      'total': total,
    };
  }

  @override
  String toString() {
    return 'UserElectricBillItem(userName: $userName, internet: $internet, unit: $unit, gElectricBill: $gElectricBill, mElectricBill: $mElectricBill, oExpend: $oExpend, total: $total)';
  }
}

class UserValidationStatus {
  bool isGenericValid;
  bool isMeterReading;
  bool isAdditionalReading;
  bool isMeterReadingNotEmpty;
  bool isAdditionalReadingNotEmpty;

  UserValidationStatus({
    this.isGenericValid = false,
    this.isMeterReading = false,
    this.isAdditionalReading = false,
    this.isMeterReadingNotEmpty = false,
    this.isAdditionalReadingNotEmpty = false,
  });

  @override
  String toString() {
    return '''
UserValidationStatus(
  isGenericValid: $isGenericValid,
  isMeterReading: $isMeterReading,
  isAdditionalReading: $isAdditionalReading,
  isMeterReadingNotEmpty: $isMeterReadingNotEmpty,
  isAdditionalReadingNotEmpty: $isAdditionalReadingNotEmpty
)''';
  }

  bool get isValid => isGenericValid && isMeterReading && isAdditionalReading && isMeterReadingNotEmpty && isAdditionalReadingNotEmpty;
}
