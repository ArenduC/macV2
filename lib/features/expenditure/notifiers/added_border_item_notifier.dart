import 'package:flutter/material.dart';
import 'package:maca/features/expenditure/model/border_item.dart';
import 'package:maca/features/expenditure/model/establishment_item.dart';

final ValueNotifier<List<AddedBorderItem>> addedBorderListNotifier = ValueNotifier<List<AddedBorderItem>>([]);
final ValueNotifier<List<EstablishmentItem>> establishmentNotifier = ValueNotifier<List<EstablishmentItem>>([]);
