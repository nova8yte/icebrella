import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:icebrella_health/entity/logging.dart';
import 'package:flutter/foundation.dart';

part 'logs_state.dart';
part 'logs_event.dart';

class LogsBloc extends HydratedBloc<LogsEvent, LogsState> {
  LogsBloc() : super(const LogsState(logs: <Logging>[])) {
    on<UpdateLogging>((event, emit) {
      var items = List<Logging>.from(state.logs);
      var index =
          items.indexWhere((medicament) => event.oldLogging == medicament);
      items[index] = event.newLogging.setId(index);
      emit(state.copyWith(logs: items));
    });
    on<AddLogging>((event, emit) {
      emit(state.copyWith(
          logs: [...state.logs, event.logging.setId(state.logs.length)]));
    });

    on<DeleteLogging>((event, emit) {
      emit(
        state.copyWith(
          logs: List<Logging>.from(
            [...state.logs]..removeAt(event.id),
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
  LogsState? fromJson(Map<String, dynamic> json) => LogsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LogsState state) => state.toJson();
}
