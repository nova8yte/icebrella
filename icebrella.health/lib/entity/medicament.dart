import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:icebrella_health/entity/mass_types.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';

abstract class BaseMedicament extends Equatable {
  final String name;
  final String? description;
  final MassType measure;
  final double amount;
  final double quantity;
  final Color color;

  const BaseMedicament(
      {required this.name,
      required this.measure,
      required this.amount,
      required this.quantity,
      this.description,
      this.color = AppColors.buttonHomeActive});

  @override
  List<Object?> get props =>
      [name, description, measure, amount, quantity, color];
}

class NonAssignedMedicament extends BaseMedicament {
  const NonAssignedMedicament(
      {required String name,
      required MassType measure,
      required double amount,
      required double quantity,
      String? description,
      Color color = AppColors.buttonHomeActive})
      : super(
            name: name,
            measure: measure,
            amount: amount,
            quantity: quantity,
            description: description,
            color: color);

  Medicament setId(int id) => Medicament(
      id: id,
      name: name,
      measure: measure,
      amount: amount,
      quantity: quantity,
      description: description,
      color: color);

  @override
  List<Object?> get props =>
      [name, description, measure, amount, quantity, color];
}

class Medicament extends BaseMedicament {
  final int id;
  const Medicament(
      {required this.id,
      required String name,
      required MassType measure,
      required double amount,
      required double quantity,
      String? description,
      Color color = AppColors.buttonHomeActive})
      : super(
            name: name,
            measure: measure,
            amount: amount,
            quantity: quantity,
            description: description,
            color: color);

  @override
  List<Object?> get props =>
      [id, name, description, measure, amount, quantity, color];
}

enum MedicamentType {
  pill,
  injectable,
  tablet,
  powder,
}

extension MedicamentConverter on MedicamentType {
  FlatIcon getIcon() {
    switch (this) {
      case MedicamentType.tablet:
        return AppIcons.tablets_small();
        break;
      case MedicamentType.pill:
        return AppIcons.pill_small();
        break;
      case MedicamentType.powder:
        return FlatIcon('');
      case MedicamentType.injectable:
        return AppIcons.syringe_small();
      default:
        return AppIcons.syringe_small();
    }
  }
}
