import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icebrella_health/bloc/meds/meds_bloc.dart';
import 'package:icebrella_health/entity/mass_types.dart';
import 'package:icebrella_health/entity/medicament.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';
import 'package:icebrella_health/ui/screens/medication/widget/modal_bottomsheet_add_meds.dart';
import 'package:icebrella_health/ui/widgets/gradient_text.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class NewMedicationScreen extends StatelessWidget {
  NewMedicationScreen({Key? key}) : super(key: key);

  final TextEditingController nameController =
      TextEditingController(text: "Фемостон 2/10");
  final FocusNode nameFocus = FocusNode(canRequestFocus: true);

  final TextEditingController amountController =
      TextEditingController(text: "10");
  final FocusNode amountFocus = FocusNode(canRequestFocus: true);
  String massType = const MassKG(0.0).asString;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedsBloc, MedsState>(builder: (context, state) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.homeBackgroundGr,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
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
                  children: [
                    GradientText(
                      "New medicament",
                      gradient: AppColors.appBarTextGr,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            child: ListView(shrinkWrap: true, children: [
              const Center(
                child: Text(
                  "New med",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 42),
              AppIcons.syringe_big(),
              Center(
                child: Container(
                  constraints: const BoxConstraints(
                      maxHeight: 38,
                      minHeight: 32,
                      maxWidth: 180,
                      minWidth: 160),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.5),
                      color: Colors.white),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TextField(
                          cursorHeight: 5,
                          focusNode: nameFocus,
                          controller: nameController,
                          style: const TextStyle(
                              color: AppColors.inContainerText,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 7),
                      InkWell(
                        child: AppIcons.pen(),
                        onTap: nameFocus.requestFocus,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  constraints: const BoxConstraints(
                      maxHeight: 38,
                      minHeight: 32,
                      maxWidth: 160,
                      minWidth: 100),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.5),
                      color: Colors.white),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          cursorHeight: 5,
                          focusNode: amountFocus,
                          controller: amountController,
                          style: const TextStyle(
                              color: AppColors.inContainerText,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 7),
                      SizedBox(
                        width: 40,
                        child: WheelChooser(
                            onValueChanged: (p0) {
                              massType = p0;
                            },
                            datas: MassType.mappedMass.keys.toList()),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              _sectionTypeText('Select Type'),
              SizedBox(
                height: 82,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 17.5),
                    _medTypeContainer(AppIcons.pill_small()),
                    _medTypeContainer(AppIcons.syringe_small()),
                    _medTypeContainer(AppIcons.tablets_small()),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              _sectionTypeText('Schedule'),
              SizedBox(
                height: 42,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 25),
                    textBage("With Meal"),
                    textBage("After Dinner"),
                    addBage(),
                    const SizedBox(width: 25),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const SizedBox(width: 34),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTypeText('Duration', addLeftPadding: false),
                      selectBage("1 Month")
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTypeText('Frequency', addLeftPadding: false),
                        selectBage("each day")
                      ],
                    ),
                  ),
                  const SizedBox(width: 45),
                ],
              ),
              const SizedBox(height: 25),
              MaterialButton(
                minWidth: 180,
                height: 50,
                onPressed: () => BlocProvider.of<MedsBloc>(context).add(
                  AddMedicament(
                    medicament: NonAssignedMedicament(
                        name: nameController.text,
                        amount: double.parse(amountController.text),
                        measure: MassType.mappedMass[massType]!,
                        quantity: 0,
                        description: ''),
                  ),
                ),
                child: Container(
                  constraints: const BoxConstraints(
                      maxHeight: 38,
                      minHeight: 32,
                      maxWidth: 180,
                      minWidth: 160),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.5),
                      color: AppColors.activeIcon),
                  child: const Center(
                      child: Text('Save',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold))),
                ),
              )
            ]),
          ),
        ),
      );
    });
  }

  Widget textBage(String text) => Center(
        child: Container(
          height: 33,
          margin: const EdgeInsets.symmetric(horizontal: 10.5),
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
              const SizedBox(width: 7),
              InkWell(
                customBorder: const CircleBorder(),
                child: const Icon(Icons.close,
                    color: AppColors.activeIcon, size: 18),
                onTap: () {},
              ),
            ],
          ),
        ),
      );

  Widget addBage() => Center(
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {},
          child: Container(
              height: 33,
              width: 34,
              margin: const EdgeInsets.symmetric(horizontal: 10.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.5),
                  color: Colors.white),
              child: const Icon(Icons.add, color: AppColors.activeIcon)),
        ),
      );

  Widget selectBage(
    String text,
  ) =>
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.5),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.5), color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text,
                  style: const TextStyle(
                      color: AppColors.inContainerText,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 7),
              const Icon(Icons.arrow_drop_down, size: 18),
            ],
          ),
        ),
      );

  _medTypeToWidget() {
    MedicamentType.values.map((e) => null);
  }

  /// Widgets

  Widget _sectionTypeText(String text, {bool addLeftPadding = true}) => Padding(
        padding: EdgeInsets.only(
            left: addLeftPadding ? 35 : 0, bottom: 11, right: 35),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text, style: const TextStyle(color: AppColors.white))),
      );

  Widget _medTypeContainer(FlatIcon icon) => Container(
        height: 82,
        width: 86,
        margin: const EdgeInsets.symmetric(horizontal: 17.5),
        decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(26)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: icon,
        ),
      );

  Widget _desc(BuildContext context) {
    return Container(child: const Text(""));
  }
}
