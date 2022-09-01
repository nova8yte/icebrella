import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icebrella_health/bloc/logs/logs_bloc.dart';
import 'package:icebrella_health/entity/logging.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';
import 'package:icebrella_health/ui/screens/logs/widget/modal_bottomsheet_add_logs.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class LogsScreen extends StatelessWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Row(
            children: [
              InkWell(
                customBorder: const CircleBorder(),
                child: AppIcons.icon_back(),
                onTap: () => Modular.to.pop(context),
              ),
              const SizedBox(width: 9),
              Column(
                children: const [
                  Text("logs",
                      style: TextStyle(
                          color: AppColors.appBarIcon,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: AppIcons.settings(),
              splashRadius: 20,
              onPressed: () => Modular.to.pushNamed('/settings'),
            )
          ],
        ),
        backgroundColor: AppColors.background,
        floatingActionButton: (state.logs.isEmpty)
            ? null
            : FloatingActionButton(
                onPressed: () => _modalBottomSheetMenu(context, state: state),
                child: const Icon(Icons.add),
                backgroundColor: AppColors.buttonHomeText,
                elevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                disabledElevation: 0,
                highlightElevation: 0,
              ),
        body: (state.logs.isEmpty)
            ? _noLogsWidget(context, state)
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 7, bottom: 7, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.list_alt,
                                  size: 23,
                                  color: AppColors.darkIcon,
                                ),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "last one",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(width: 2),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 3.0),
                                      child: AppIcons.pen(
                                          color: AppColors.darkIcon),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        Logging log = state.logs[index];
                        Color textColor = log.color.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white;
                        final ValueNotifier<bool> showDescription =
                            ValueNotifier<bool>(false);

                        return Slidable(
                          key: UniqueKey(),
                          endActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),
                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(
                              onDismissed: () {
                                BlocProvider.of<LogsBloc>(context)
                                    .add(DeleteLogging(id: index));
                              },
                              closeOnCancel: false,
                            ),

                            // All actions are defined in the children parameter.
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                spacing: 1,
                                onPressed: (BuildContext context) =>
                                    _modalBottomSheetMenu(context,
                                        logging: log, state: state),
                                backgroundColor: AppColors.background,
                                foregroundColor: AppColors.activeIcon,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                spacing: 1,
                                onPressed: (BuildContext context) =>
                                    BlocProvider.of<LogsBloc>(context)
                                        .add(DeleteLogging(id: index)),
                                backgroundColor: AppColors.background,
                                foregroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 15, right: 18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: log.color),
                            child: TextButton(
                              onPressed: () => showDescription.value =
                                  !showDescription.value,
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 18),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            log.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: textColor),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: Chip(
                                            padding: const EdgeInsets.only(
                                                top: 15,
                                                right: 14,
                                                left: 17,
                                                bottom: 16),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                            backgroundColor:
                                                _getTimeAgoColor(log.updated),
                                            labelPadding: EdgeInsets.zero,
                                            label: Text(
                                                _getTimeAgo(log.updated),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: _getTimeAgoColor(
                                                                    log.updated)
                                                                .computeLuminance() >
                                                            0.5
                                                        ? Colors.black
                                                        : Colors.white)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, right: 18),
                                      child: ValueListenableBuilder<bool>(
                                          valueListenable: showDescription,
                                          builder: (context, value, child) {
                                            return value
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        (log.action.length) < 30
                                                            ? ((log.action
                                                                        .length) >
                                                                    20
                                                                ? (log.action.substring(
                                                                            0,
                                                                            20))
                                                                        .trimRight() +
                                                                    "..."
                                                                : log.action)
                                                            : "see more",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: textColor),
                                                      ),
                                                      Text(
                                                        (log.medicament?.name
                                                                        .length ??
                                                                    0) <
                                                                30
                                                            ? ((log.medicament?.name
                                                                            .length ??
                                                                        0) >
                                                                    20
                                                                ? (log.medicament!
                                                                            .name
                                                                            .substring(0,
                                                                                20))
                                                                        .trimRight() +
                                                                    "..."
                                                                : log.medicament
                                                                        ?.name ??
                                                                    "no med")
                                                            : "med",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: textColor),
                                                      ),
                                                      const Divider(
                                                          color: AppColors
                                                              .darkIcon),
                                                      Text(
                                                        log.description!,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: textColor),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                    ],
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        (log.action.length) < 30
                                                            ? ((log.action
                                                                        .length) >
                                                                    20
                                                                ? (log.action.substring(
                                                                            0,
                                                                            20))
                                                                        .trimRight() +
                                                                    "..."
                                                                : log.action)
                                                            : "see more",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: textColor),
                                                      ),
                                                      Text(
                                                        (log.medicament?.name
                                                                        .length ??
                                                                    0) <
                                                                30
                                                            ? ((log.medicament?.name
                                                                            .length ??
                                                                        0) >
                                                                    20
                                                                ? (log.medicament!
                                                                            .name
                                                                            .substring(0,
                                                                                20))
                                                                        .trimRight() +
                                                                    "..."
                                                                : log.medicament
                                                                        ?.name ??
                                                                    "no med")
                                                            : "med",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: textColor),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              (log.description
                                                                              ?.length ??
                                                                          0) <
                                                                      30
                                                                  ? ((log.description?.length ??
                                                                              0) >
                                                                          20
                                                                      ? (log.description?.substring(0, 20) ?? "")
                                                                              .trimRight() +
                                                                          "..."
                                                                      : log.description ??
                                                                          "missing")
                                                                  : "see more",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      textColor),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(
                                                          color: AppColors
                                                              .darkIcon),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.logs.length,
                    ),
                  ),
                ],
              ),
      );
    });
  }

  Widget _noLogsWidget(BuildContext context, LogsState state) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              AppIcons.clipboard(width: 250, height: 270),
              const SizedBox(height: 21),
              const Text("No logs yet.",
                  style: TextStyle(
                      color: AppColors.inactiveIcon,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        MaterialButton(
          color: AppColors.buttonHomeText,
          elevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          disabledElevation: 0,
          highlightElevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          height: 80,
          minWidth: 260,
          onPressed: () {
            _modalBottomSheetMenu(context, state: state);
          },
          child: Column(
            children: [
              Icon(
                Icons.add,
                color: Colors.white.withOpacity(0.67),
              ),
              Text("tap on me",
                  style: TextStyle(color: Colors.white.withOpacity(0.67)))
            ],
          ),
        )
      ],
    );
  }

  Color _getTimeAgoColor(DateTime updated) {
    DateTime current = DateTime.now();
    Duration difference = updated.difference(current);
    int minutes = difference.inMinutes;
    int hours = difference.inHours;
    int days = difference.inDays;
    double months = (days / 30.417) * 100;
    if (minutes < 60) {
      return AppColors.timeAgoColorList[0];
    } else if (hours < 12) {
      return AppColors.timeAgoColorList[1];
    } else if (days < 7) {
      return AppColors.timeAgoColorList[2];
    } else if (months < 3) {
      return AppColors.timeAgoColorList[3];
    } else if (months < 6) {
      return AppColors.timeAgoColorList[4];
    }
    return AppColors.timeAgoColorList[5];
  }

  String _getTimeAgo(DateTime updated) {
    DateTime current = DateTime.now();
    if (updated.difference(current).inDays < 31) {
      return timeago.format(updated, locale: "en_short");
    } else {
      return "${updated.day} ${DateFormat.MMM().format(updated).toLowerCase()}";
    }
  }

  void _modalBottomSheetMenu(BuildContext context,
      {Logging? logging, required LogsState state}) {
    showModalBottomSheet(
        backgroundColor: AppColors.background,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (_) {
          return ModalBottomSheetAddLogsWidget(
            logging: logging,
            state: state,
          );
        });
  }
}
