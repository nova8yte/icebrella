part of 'meds_bloc.dart';

@immutable
abstract class MedsEvent {}

class UpdateMedicament extends MedsEvent {
  final Medicament oldMedicament;

  final NonAssignedMedicament newMedicament;
  UpdateMedicament({required this.oldMedicament, required this.newMedicament});
}

class AddMedicament extends MedsEvent {
  final NonAssignedMedicament medicament;
  AddMedicament({
    required this.medicament,
  });
}

class DeleteMedicament extends MedsEvent {
  final int id;
  DeleteMedicament({required this.id});
}
