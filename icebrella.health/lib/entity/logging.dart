import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:icebrella_health/entity/medicament.dart';
import 'package:icebrella_health/values/style/colors.dart';

class LoggingType extends Equatable {
  final String name;
  final String action;
  final String? description;
  final DateTime created;
  final DateTime updated;
  final Medicament? medicament;
  final Color color;

  const LoggingType(
      {required this.name,
      required this.action,
      required this.created,
      required this.updated,
      required this.medicament,
      this.description,
      this.color = AppColors.buttonHomeActive});

  @override
  List<Object?> get props =>
      [name, action, description, medicament, created, updated, color];
}

class NonAssignedLogging extends LoggingType {
  const NonAssignedLogging(
      {required String name,
      required String action,
      required DateTime created,
      required DateTime updated,
      required Medicament? medicament,
      String? description,
      Color color = AppColors.buttonHomeActive})
      : super(
            name: name,
            action: action,
            created: created,
            updated: updated,
            medicament: medicament,
            description: description,
            color: color);

  Logging setId(int id) => Logging(
      id: id,
      description: description,
      name: name,
      action: action,
      created: created,
      updated: updated,
      medicament: medicament);

  @override
  List<Object?> get props =>
      [name, action, description, medicament, created, updated, color];
}

class Logging extends LoggingType {
  final int id;
  const Logging(
      {required this.id,
      required String name,
      required String action,
      required DateTime created,
      required DateTime updated,
      required Medicament? medicament,
      String? description,
      Color color = AppColors.buttonHomeActive})
      : super(
            name: name,
            action: action,
            created: created,
            updated: updated,
            medicament: medicament,
            description: description,
            color: color);

  @override
  List<Object?> get props =>
      [id, name, action, description, medicament, created, updated, color];
}
