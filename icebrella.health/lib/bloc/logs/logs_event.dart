part of 'logs_bloc.dart';

@immutable
abstract class LogsEvent {}

class UpdateLogging extends LogsEvent {
  final Logging oldLogging;

  final NonAssignedLogging newLogging;
  UpdateLogging({required this.oldLogging, required this.newLogging});
}

class AddLogging extends LogsEvent {
  final NonAssignedLogging logging;
  AddLogging({
    required this.logging,
  });
}

class DeleteLogging extends LogsEvent {
  final int id;
  DeleteLogging({required this.id});
}
