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
