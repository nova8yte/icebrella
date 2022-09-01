part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final int currentPage;
  final int selectedDay;
  const HomeState({required this.currentPage, required this.selectedDay});

  @override
  List<Object?> get props => [currentPage, selectedDay];
}

class NextPageState extends HomeState {
  const NextPageState({required int currentPage, int selectedDay = 0})
      : super(currentPage: currentPage, selectedDay: selectedDay);
}

class SelectDayState extends HomeState {
  const SelectDayState({required int selectedDay})
      : super(currentPage: 0, selectedDay: selectedDay);
}
