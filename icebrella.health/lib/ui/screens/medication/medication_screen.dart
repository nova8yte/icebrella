import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icebrella_health/bloc/meds/meds_bloc.dart';
import 'package:icebrella_health/entity/medicament.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';
import 'package:icebrella_health/ui/screens/medication/widget/modal_bottomsheet_add_meds.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedsBloc, MedsState>(builder: (context, state) {
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
                  Text("meds",
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
              icon: AppIcons.user_circle(active: false),
              splashRadius: 20,
              onPressed: () => Modular.to.pushNamed('/settings'),
            )
          ],
        ),
        backgroundColor: AppColors.background,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: (state.meds.isEmpty)
            ? null
            : FloatingActionButton(
                onPressed: () => _modalBottomSheetMenu(context),
                child: const Icon(Icons.add),
                backgroundColor: AppColors.buttonHomeText,
                elevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                disabledElevation: 0,
                highlightElevation: 0,
              ),
        body: (state.meds.isEmpty)
            ? _noMedsWidget(context)
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
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child:
                                        AppIcons.pen(color: AppColors.darkIcon),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        Medicament med = state.meds[index];
                        Color textColor = med.color.computeLuminance() > 0.5
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
                                BlocProvider.of<MedsBloc>(context)
                                    .add(DeleteMedicament(id: index));
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
                                        medicament: med),
                                backgroundColor: AppColors.background,
                                foregroundColor: AppColors.activeIcon,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                spacing: 1,
                                onPressed: (BuildContext context) =>
                                    BlocProvider.of<MedsBloc>(context)
                                        .add(DeleteMedicament(id: index)),
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
                                color: med.color),
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
                                    margin: const EdgeInsets.only(
                                        top: 10.0, right: 18.0),
                                    padding: const EdgeInsets.only(
                                        top: 18.0, left: 15, right: 18.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            med.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: textColor),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: Text(
                                            "${med.amount}${med.measure.asString} x ${med.quantity}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: textColor),
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
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      const Divider(
                                                          color: AppColors
                                                              .darkIcon),
                                                      Text(
                                                        med.description!,
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
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              (med.description
                                                                              ?.length ??
                                                                          0) <
                                                                      30
                                                                  ? ((med.description?.length ??
                                                                              0) >
                                                                          20
                                                                      ? (med.description?.substring(0, 20) ?? "")
                                                                              .trimRight() +
                                                                          "..."
                                                                      : med.description ??
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
                      itemCount: state.meds.length,
                    ),
                  ),
                ],
              ),
      );
    });
  }

  Widget _desc(BuildContext context) {
    return Container(child: Text(""));
  }

  Widget _noMedsWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              AppIcons.tablet,
              const SizedBox(height: 21),
              const Text("No meds yet.",
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
            _modalBottomSheetMenu(context);
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

  void _modalBottomSheetMenu(BuildContext context, {Medicament? medicament}) {
    showModalBottomSheet(
        backgroundColor: AppColors.buttonHomeText,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        builder: (_) {
          return ModalBottomSheetAddMedsWidget(
            medicament: medicament,
          );
        });
  }
}
