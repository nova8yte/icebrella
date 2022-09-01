import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:icebrella_health/entity/medicament.dart';
import 'package:flutter/foundation.dart';

part 'meds_state.dart';
part 'meds_event.dart';

class MedsBloc extends HydratedBloc<MedsEvent, MedsState> {
  MedsBloc() : super(const MedsState(meds: <Medicament>[])) {
    on<UpdateMedicament>((event, emit) {
      var items = List<Medicament>.from(state.meds);
      var index =
          items.indexWhere((medicament) => event.oldMedicament == medicament);
      items[index] = event.newMedicament.setId(index);
      emit(state.copyWith(meds: items));
    });
    on<AddMedicament>((event, emit) {
      emit(state.copyWith(
          meds: [...state.meds, event.medicament.setId(state.meds.length)]));
    });

    on<DeleteMedicament>((event, emit) {
      emit(
        state.copyWith(
          meds: List<Medicament>.from(
            [...state.meds]..removeAt(event.id),
          ),
        ),
      );
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    super.onError(error, stackTrace);
  }

  @override
  MedsState? fromJson(Map<String, dynamic> json) => MedsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MedsState state) => state.toJson();
}
