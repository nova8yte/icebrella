part of 'meds_bloc.dart';

class MedsState extends Equatable {
  final List<Medicament> meds;
  const MedsState({required this.meds});

  Map<String, dynamic> toJson() => {'meds': ""};

  static MedsState fromJson(Map<String, dynamic> json) => const MedsState(meds: []);

  MedsState copyWith({List<Medicament>? meds}) => MedsState(meds: meds ?? this.meds);

  static MedsState clear() => const MedsState(meds: []);

  @override
  List<Object?> get props => [meds];
}
