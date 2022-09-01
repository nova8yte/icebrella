import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icebrella_health/bloc/home/home_bloc.dart';
import 'package:icebrella_health/bloc/meds/meds_bloc.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';
import 'package:icebrella_health/values/translation/strings.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  ScrollController scrollController = ScrollController();
  String swipeDirection = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var index = BlocProvider.of<HomeBloc>(context).state.selectedDay;
        var extent = 0.0;
        if (index == AppStrings.dayOfTheWeekList.length - 1) {
          extent = scrollController.position.maxScrollExtent;
        } else if (index == 0) {
          extent = scrollController.position.minScrollExtent;
        } else {
          extent = scrollController.position.maxScrollExtent -
              (scrollController.position.maxScrollExtent / index);
        }
        Timer(
            const Duration(milliseconds: 400),
            () => scrollController.animateTo(extent,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 800)));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state is SelectDayState) {
        var index = state.selectedDay;
        var extent = 0.0;
        if (index == AppStrings.dayOfTheWeekList.length - 1) {
          extent = scrollController.position.maxScrollExtent;
        } else if (index == 0) {
          extent = scrollController.position.minScrollExtent;
        } else {
          extent = index.toDouble() * 25;
        }
        scrollController.animateTo(
          extent,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 800),
        );
      }
    }, builder: (context, homeState) {
      var size = MediaQuery.of(context).size;
      return SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Column(
              children: [
                //const DottedLine(color: AppColors.inactiveIcon, height: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: SizedBox(
                    height: 29,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) => _dayOfTheWeek(
                            index: index, state: homeState, context: context)),
                        itemCount: AppStrings.dayOfTheWeekList.length),
                  ),
                ),
                //const DottedLine(color: AppColors.inactiveIcon, height: 3),
                BlocBuilder<MedsBloc, MedsState>(builder: (context, state) {
                  return (state.meds.isNotEmpty)
                      ? Flexible(
                          child: ListView.builder(
                              itemBuilder: ((context, index) =>
                                  _medication(context, index)),
                              itemCount: state.meds.length),
                        )
                      : const SizedBox(
                          height: 75,
                          child: Center(
                              child: Text(
                            "No medications, yet",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )));
                }),
              ],
            ),
          ],
        ),
        /*Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
                  if (details.delta.dx < -10) {
                    swipeDirection = "left";
                  } else if (details.delta.dx > 10) {
                    swipeDirection = "right";
                  } else {
                    swipeDirection = "none";
                  }
                },
                onHorizontalDragEnd: (details) {
                  var index = homeState.selectedDay;
                  var extent = 0.0;

                  // swipe left
                  if (swipeDirection == "right") {
                    if (index == AppStrings.dayOfTheWeekList.length - 1) {
                      index--;
                    } else if (index == 0) {
                      // do nothing
                    } else {
                      index--;
                    }
                    extent = index.toDouble() * 25;
                    BlocProvider.of<HomeBloc>(context)
                        .add(SelectDay(selectedDay: index));
                  }
                  // swipe right
                  else if (swipeDirection == "left") {
                    if (index == AppStrings.dayOfTheWeekList.length - 1) {
                      // do nothing
                    } else if (index == 0) {
                      index++;
                    } else {
                      index++;
                    }
                    extent = index.toDouble() * 25;
                    BlocProvider.of<HomeBloc>(context)
                        .add(SelectDay(selectedDay: index));
                  }
                  Timer(
                      const Duration(milliseconds: 100),
                      () => scrollController.animateTo(extent,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 400)));
                },
                child: Container(
                    height: size.height / 2,
                    width: size.width,
                    color: Colors.transparent),
              ),
            ),
            */
      );
    });
  }

  Widget _medication(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.35)),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 15, right: 18),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 30),
                      child: AppIcons.pill_small()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Vitamin d3',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white)),
                      const SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          textBage('With Meal'),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.fullscreen,
                    color: AppColors.white,
                    size: 24 + 12,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget textBage(String text) => Center(
      child: Container(
        height: 33,
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.5), color: Colors.white),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,
                style: const TextStyle(
                    color: AppColors.inContainerText,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );

String get currentDayOfTheWeek =>
    DateFormat('EEEE').format(DateTime.now()).substring(0, 3);

/* Drag and Drop has deprecated
ValueNotifier<DragAndDropList> dragAndDropList = ValueNotifier<DragAndDropList>(
  DragAndDropList(
    children: [
      DragAndDropItem(
        child: BlocBuilder<MedsBloc, MedsState>(
          builder: (context, state) => ListItemButton("Meds",
              onPressed: () => Modular.to.pushNamed('/medication'),
              icon: AppIcons.tablet_rotated(
                  width: 34, height: 60, color: Colors.white),
              itemsAmount: state.meds.length),
        ),
      ),
      DragAndDropItem(
        child: BlocBuilder<LogsBloc, LogsState>(builder: (context, state) {
          return ListItemButton(
            "Logs",
            onPressed: () => Modular.to.pushNamed('/logs'),
            icon: AppIcons.clipboard(
                height: 59, width: 60, color: AppColors.buttonHomeText),
            iconContainerColor: Colors.white,
            itemsAmount: state.logs.length,
          );
        }),
      ),
      DragAndDropItem(
        child: ListItemButton(
          "Labs",
          onPressed: () => Modular.to.pushNamed(
            '/labs',
          ),
          icon: AppIcons.flask(width: 34, height: 60, color: Colors.white),
        ),
      ),
      DragAndDropItem(
        canDrag: false,
        child: ListItemButton("Coming Later",
            active: false,
            onPressed: () {},
            icon: AppIcons.doctor(
                width: 34,
                height: 60,
                color: AppColors.buttonHomeText.withOpacity(0.3)),
            iconContainerColor: Colors.white),
      ),
    ],
  ),
);
*/

_dayOfTheWeek(
    {required BuildContext context,
    required int index,
    required HomeState state}) {
  bool active = AppStrings.dayOfTheWeekList[state.selectedDay] ==
      AppStrings.dayOfTheWeekList[index];
  bool isCurrentDay = index == HomeBloc.activeDayIndex();
  Color bgColor = AppColors.dayOfTheWeekInactive;
  Color textColor = AppColors.inactiveIcon;
  if (active) {
    bgColor = AppColors.dayOfTheWeekActive;
    textColor = AppColors.activeIcon;
  }
  if (isCurrentDay && !active) {
    bgColor = Colors.white.withOpacity(0.35);
    textColor = AppColors.inContainerText;
  }
  if (!active && !isCurrentDay) {
    bgColor = AppColors.dayOfTheWeekInactive;
    textColor = AppColors.inactiveIcon;
  }
  return Row(
    children: [
      SizedBox(width: index == 0 ? 13 : 0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.5),
        child: InkWell(
          onTap: () {
            BlocProvider.of<HomeBloc>(context)
                .add(SelectDay(selectedDay: index));
          },
          child: Container(
            width: active ? 75 : 60,
            height: 29,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Text(AppStrings.dayOfTheWeekList[index],
                    style: TextStyle(
                        fontSize: 12,
                        color: textColor,
                        fontWeight: FontWeight.w700))),
          ),
        ),
      ),
    ],
  );
}
