import 'package:equatable/equatable.dart';
import 'package:measures/measures.dart';

abstract class MassType extends Equatable {
  final num value;
  const MassType(this.value);

  static const mappedMass = <String, MassType>{
    "kg": MassKG(0.0),
    "oz": MassOz(0.0),
    "gr": MassGr(0.0),
    "lb": MassLb(0.0)
  };
  String get asString => "kg";

  Mass get toMass => Mass.fromKg(value);
  MassType addMass(num value) => MassKG(value);

  @override
  List<Object?> get props => [value];
}

class MassKG extends MassType {
  const MassKG(num value) : super(value);

  @override
  Mass get toMass => Mass.fromKg(value);
  @override
  MassKG addMass(num value) => MassKG(value);

  @override
  String get asString => "kg";
}

class MassOz extends MassType {
  const MassOz(num value) : super(value);

  @override
  Mass get toMass => Mass.fromOz(value);
  @override
  MassOz addMass(num value) => MassOz(value);

  @override
  String get asString => "oz";
}

class MassGr extends MassType {
  const MassGr(num value) : super(value);

  @override
  Mass get toMass => Mass.fromGr(value);
  @override
  MassGr addMass(num value) => MassGr(value);

  @override
  String get asString => "gr";
}

class MassLb extends MassType {
  const MassLb(num value) : super(value);

  @override
  Mass get toMass => Mass.fromLb(value);
  @override
  MassLb addMass(num value) => MassLb(value);

  @override
  String get asString => "lb";
}
