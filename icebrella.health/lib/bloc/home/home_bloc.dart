import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:icebrella_health/values/translation/strings.dart';
import 'package:intl/intl.dart';
part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(NextPageState(currentPage: 0, selectedDay: activeDayIndex())) {
    on<NextPage>((event, emit) {
      emit(NextPageState(
          currentPage: event.nextPage, selectedDay: state.selectedDay));
    });
    on<SelectDay>((event, emit) {
      emit(SelectDayState(selectedDay: event.selectedDay));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    super.onError(error, stackTrace);
  }

  static int activeDayIndex() {
    var date = DateTime.now();
    var dayOfTheWeek = DateFormat('EEEE').format(date).substring(0, 3);
    return AppStrings.dayOfTheWeekList.indexOf(dayOfTheWeek);
  }
}
