// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:icebrella_health/ui/widgets/onboarding/onboarding_addmeds.dart';
import 'package:icebrella_health/ui/widgets/onboarding/onboarding_lastboard.dart';
import 'package:icebrella_health/ui/widgets/onboarding/onboarding_medcase.dart';
import 'package:icebrella_health/ui/widgets/onboarding/onboarding_takenotes.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';
import 'package:icebrella_health/utils/shared_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingStack extends StatefulWidget {
  const OnboardingStack({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnboardingStackState();
}

class _OnboardingStackState extends State<OnboardingStack>
    with TickerProviderStateMixin {
  final PageController pageController = PageController();
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(1);

  final ValueNotifier<int> colorIndexNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      final int page = ((pageController.hasClients)
          ? ((pageController.page?.toInt()) ?? 1)
          : 0);
    });
  }

  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: colorIndexNotifier,
          builder: (context, int index, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              onEnd: () {},
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.onboardingColorsGrList[index],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            );
          },
        ),
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: _stack,
        ),
        ValueListenableBuilder(
          valueListenable: currentPageNotifier,
          builder: (context, int page, child) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 56.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 50,
                      icon: AppIcons.arrow_right(),
                      onPressed: nextPage,
                    ),
                    const SizedBox(height: 11),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10 * page.toDouble()),
                        SmoothPageIndicator(
                          controller: pageController,
                          count: 4,
                          effect: const ExpandingDotsEffect(
                              dotHeight: 6,
                              dotWidth: 6,
                              expansionFactor: 3.5,
                              dotColor: AppColors.inactiveIcon,
                              activeDotColor: Colors.white),
                        ),
                        SizedBox(width: 10 * page.toDouble())
                      ],
                    ),
                    const SizedBox(height: 17),
                    const Text("icebrella.space",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> get _stack => const [
        OnboardingMedCase(),
        OnboardingAddMeds(),
        OnboardingTakeNotes(),
        OnboardingLastBoard(),
      ];

  void nextPage() {
    final page = pageController.page!;
    colorIndexNotifier.value =
        ((pageController.page?.toInt() ?? 1) + 1).clamp(0, 3);
    page < 2.5
        ? pageController.nextPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.decelerate)
        : finishOnboarding(true);
  }

  void finishOnboarding(bool isFinished) async {
    await GetIt.I<SharedPreferences>()
        .setBool(SharedKeys.finishedOnboarding, true);
    Modular.to.navigate('/home');
  }

  void changeColor() {}
}
