part of 'logs_bloc.dart';

class LogsState extends Equatable {
  final List<Logging> logs;
  const LogsState({required this.logs});

  Map<String, dynamic> toJson() => {'logs': ""};

  static LogsState fromJson(Map<String, dynamic> json) => const LogsState(logs: []);

  LogsState copyWith({List<Logging>? logs}) => LogsState(logs: logs ?? this.logs);

  static LogsState clear() => const LogsState(logs: []);

  @override
  List<Object?> get props => [logs];
}
