// ignore_for_file: must_be_immutable, unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icebrella_health/bloc/meds/meds_bloc.dart';
import 'package:icebrella_health/entity/mass_types.dart';
import 'package:icebrella_health/entity/medicament.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';

class ModalBottomSheetAddMedsWidget extends StatefulWidget {
  final Key dismissibleKey;
  final Medicament? medicament;
  // Nodes
  final FocusNode nameFocusNode;
  final FocusNode descFocusNode;
  final FocusNode amountFocusNode;
  final FocusNode quantityFocusNode;
  ModalBottomSheetAddMedsWidget(
      {Key? key,
      Key? dismissibleKey,
      this.medicament,
      FocusNode? nameFocusNode,
      FocusNode? descFocusNode,
      FocusNode? amountFocusNode,
      FocusNode? quantityFocusNode})
      : dismissibleKey =
            dismissibleKey ?? const Key('Mo∂dalBottomSheetAddMeds'),
        nameFocusNode = nameFocusNode ?? FocusNode(canRequestFocus: true),
        descFocusNode = descFocusNode ?? FocusNode(canRequestFocus: true),
        amountFocusNode = amountFocusNode ?? FocusNode(canRequestFocus: true),
        quantityFocusNode =
            quantityFocusNode ?? FocusNode(canRequestFocus: true),
        super(key: key);
  @override
  State<StatefulWidget> createState() => ModalBottomSheetAddMedsState();
}

class ModalBottomSheetAddMedsState
    extends State<ModalBottomSheetAddMedsWidget> {
  // Text Controllers
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController amountController;
  late TextEditingController quantityController;

  final ValueNotifier<MassType> selectedMassType =
      ValueNotifier<MassType>(const MassKG(0.0));

  @override
  void initState() {
    nameController =
        TextEditingController(text: widget.medicament?.name ?? "Med name");
    descController = TextEditingController(
        text: widget.medicament?.description ?? "Description and How to Use");
    amountController = TextEditingController(
        text: (widget.medicament?.amount ?? 1.0).toString());
    quantityController = TextEditingController(
        text: (widget.medicament?.quantity ?? 1.0).toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Wrap(
          children: [
            Dismissible(
              key: widget.dismissibleKey,
              onDismissed: (direction) {
                var newMed = NonAssignedMedicament(
                  name: nameController.text,
                  description: descController.text,
                  measure: selectedMassType.value.addMass(
                    double.parse(amountController.text),
                  ),
                  quantity: double.parse(quantityController.text),
                  amount: double.parse(amountController.text),
                );
                if (widget.medicament != null) {
                  BlocProvider.of<MedsBloc>(context).add(UpdateMedicament(
                      oldMedicament: widget.medicament!,
                      newMedicament: newMed));
                } else {
                  BlocProvider.of<MedsBloc>(context).add(
                    AddMedicament(medicament: newMed),
                  );
                }
                Navigator.of(context).pop();
              },
              confirmDismiss: (direction) async =>
                  (direction == DismissDirection.startToEnd),
              direction: DismissDirection.startToEnd,
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, bottom: 10, right: 18.0),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 40,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.chevron_right,
                                  color: AppColors.darkIcon,
                                )
                              ],
                            )),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  fontWeight: FontWeight.w700),
                                              backgroundCursorColor:
                                                  AppColors.inactiveIcon,
                                              cursorColor:
                                                  AppColors.inactiveIcon,
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
                                            onTap: () => widget.nameFocusNode
                                                .requestFocus(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: EditableText(
                                                  expands: true,
                                                  forceLine: false,
                                                  maxLines: null,
                                                  controller: amountController,
                                                  focusNode:
                                                      widget.amountFocusNode,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  backgroundCursorColor:
                                                      AppColors.inactiveIcon,
                                                  cursorColor:
                                                      AppColors.inactiveIcon,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp("\d*\.\d*")),
                                                    LengthLimitingTextInputFormatter(
                                                        8), //n is maximum number of characters you want in textfield
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          ValueListenableBuilder(
                                              valueListenable: selectedMassType,
                                              builder: (context, value, child) {
                                                return SizedBox(
                                                  height: 25,
                                                  child: DropdownButton<String>(
                                                      isDense: true,
                                                      iconSize: 20,
                                                      value: selectedMassType
                                                          .value.asString,
                                                      dropdownColor:
                                                          AppColors.darkIcon,
                                                      items: List<DropdownMenuItem<String>>.generate(
                                                          MassType.mappedMass
                                                              .keys.length,
                                                          (index) => DropdownMenuItem(
                                                              value: MassType.mappedMass.keys
                                                                      .toList()[
                                                                  index],
                                                              child: Text(MassType.mappedMass.keys.toList()[index],
                                                                  style: const TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: Colors.white)))),
                                                      onChanged: (String? massType) => selectedMassType.value = MassType.mappedMass[massType]!),
                                                );
                                              }),
                                          const Text("x",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                          Flexible(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: EditableText(
                                                    expands: true,
                                                    forceLine: false,
                                                    maxLines: null,
                                                    controller:
                                                        quantityController,
                                                    focusNode: widget
                                                        .quantityFocusNode,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    backgroundCursorColor:
                                                        AppColors.inactiveIcon,
                                                    cursorColor:
                                                        AppColors.inactiveIcon,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              "\d*\.\d*")),
                                                      LengthLimitingTextInputFormatter(
                                                          8), //n is maximum number of characters you want in textfield
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  customBorder:
                                                      const CircleBorder(),
                                                  child: AppIcons.pen(
                                                      color:
                                                          AppColors.darkIcon),
                                                  onTap: () => widget
                                                      .nameFocusNode
                                                      .requestFocus(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                        backgroundCursorColor:
                                            AppColors.inactiveIcon,
                                        cursorColor: AppColors.inactiveIcon,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("\d*\.\d*")),
                                          LengthLimitingTextInputFormatter(
                                              140), //n is maximum number of characters you want in textfield
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
