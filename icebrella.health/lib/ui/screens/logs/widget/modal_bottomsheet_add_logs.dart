// ignore_for_file: must_be_immutable, unnecessary_string_escapes

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icebrella_health/bloc/logs/logs_bloc.dart';
import 'package:icebrella_health/bloc/meds/meds_bloc.dart';
import 'package:icebrella_health/entity/logging.dart';
import 'package:icebrella_health/entity/mass_types.dart';
import 'package:icebrella_health/entity/medicament.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';

class ModalBottomSheetAddLogsWidget extends StatefulWidget {
  final Key dismissibleKey;
  final Logging? logging;
  final LogsState state;
  // Nodes
  final FocusNode nameFocusNode;
  final FocusNode actionFocusNode;
  final FocusNode descFocusNode;
  ModalBottomSheetAddLogsWidget(
      {Key? key,
      Key? dismissibleKey,
      this.logging,
      required this.state,
      FocusNode? nameFocusNode,
      FocusNode? actionFocusNode,
      FocusNode? descFocusNode,
      FocusNode? amountFocusNode,
      FocusNode? quantityFocusNode})
      : dismissibleKey = dismissibleKey ?? const Key('ModalBottomSheetAddLogs'),
        nameFocusNode = nameFocusNode ?? FocusNode(canRequestFocus: true),
        actionFocusNode = actionFocusNode ?? FocusNode(canRequestFocus: true),
        descFocusNode = descFocusNode ?? FocusNode(canRequestFocus: true),
        super(key: key);
  @override
  State<StatefulWidget> createState() => ModalBottomSheetAddLogsState();
}

class ModalBottomSheetAddLogsState
    extends State<ModalBottomSheetAddLogsWidget> {
  // Text Controllers
  late TextEditingController nameController;
  late TextEditingController actionController;
  late TextEditingController descController;
  late MedsState medsState;
  late Medicament? medicament;

  final ValueNotifier<MassType> selectedMassType =
      ValueNotifier<MassType>(const MassKG(0.0));

  @override
  void initState() {
    nameController =
        TextEditingController(text: widget.logging?.name ?? "Log name");
    actionController =
        TextEditingController(text: widget.logging?.action ?? "What you did");
    descController = TextEditingController(
        text: widget.logging?.description ?? "Long Description");
    medsState = BlocProvider.of<MedsBloc>(context).state;
    medicament = medsState.meds.isNotEmpty ? medsState.meds.first : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Wrap(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, top: 18.0, bottom: 10, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: EditableText(
                                          expands: true,
                                          forceLine: false,
                                          maxLines: null,
                                          controller: nameController,
                                          focusNode: widget.nameFocusNode,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.buttonHomeText),
                                          backgroundCursorColor:
                                              AppColors.inactiveIcon,
                                          cursorColor: AppColors.inactiveIcon,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                15), //n is maximum number of characters you want in textfield
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        customBorder: const CircleBorder(),
                                        child: AppIcons.pen(
                                            color: AppColors.darkIcon),
                                        onTap: () =>
                                            widget.nameFocusNode.requestFocus(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          const SizedBox(height: 9),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: EditableText(
                                          expands: true,
                                          forceLine: false,
                                          maxLines: null,
                                          controller: actionController,
                                          focusNode: widget.actionFocusNode,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.buttonHomeText),
                                          backgroundCursorColor:
                                              AppColors.inactiveIcon,
                                          cursorColor: AppColors.inactiveIcon,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                15), //n is maximum number of characters you want in textfield
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        customBorder: const CircleBorder(),
                                        child: AppIcons.pen(
                                            color: AppColors.darkIcon),
                                        onTap: () => widget.actionFocusNode
                                            .requestFocus(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          const SizedBox(height: 9),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: EditableText(
                                    expands: true,
                                    forceLine: false,
                                    maxLines: null,
                                    controller: descController,
                                    focusNode: widget.descFocusNode,
                                    selectionColor: AppColors.activeIcon,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                    backgroundCursorColor:
                                        AppColors.inactiveIcon,
                                    cursorColor: AppColors.inactiveIcon,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('\d*\.\d*')),
                                      LengthLimitingTextInputFormatter(
                                          500), //n is maximum number of characters you want in textfield
                                    ],
                                  ),
                                ),
                                InkWell(
                                  customBorder: const CircleBorder(),
                                  child:
                                      AppIcons.pen(color: AppColors.darkIcon),
                                  onTap: () =>
                                      widget.descFocusNode.requestFocus(),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: CupertinoPicker.builder(
                              itemExtent: 30,
                              onSelectedItemChanged: (int index) =>
                                  medicament = medsState.meds[index],
                              itemBuilder: (context, index) {
                                Medicament log = medsState.meds[index];
                                return Text(log.name);
                              },
                              childCount: medsState.meds.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                          color: AppColors.activeIcon,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          elevation: 0,
                          focusElevation: 0,
                          hoverElevation: 0,
                          disabledElevation: 0,
                          highlightElevation: 0,
                          onPressed: () {
                            var newLog = NonAssignedLogging(
                                name: nameController.text,
                                action: actionController.text,
                                description: descController.text,
                                created: DateTime.now(),
                                medicament: medicament,
                                updated: DateTime.now());
                            if (widget.logging != null) {
                              BlocProvider.of<LogsBloc>(context).add(
                                  UpdateLogging(
                                      oldLogging: widget.logging!,
                                      newLogging: newLog));
                            } else {
                              BlocProvider.of<LogsBloc>(context).add(
                                AddLogging(logging: newLog),
                              );
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text("Save",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
