part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class NextPage extends HomeEvent {
  final int nextPage;
  NextPage({required this.nextPage});
}

class SelectDay extends HomeEvent {
  final int selectedDay;
  SelectDay({required this.selectedDay});
}
