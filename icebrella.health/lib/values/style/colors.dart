import 'package:flutter/widgets.dart';

class AppColors {
  static const background = Color(0xfff0fcff);

  static const appBarIcon = inactiveIcon;

  /// Icon colors
  static const inactiveIcon = white;
  static const activeIcon = Color(0xff2cbdfb);
  static const darkIcon = Color(0xff0c739f);

  static const buttonHomeActive = Color(0xffcef4ff);

  static const buttonHomeText = Color(0xff2cbdfb);

  static const inContainerText = Color(0xff3996c0);

  static const dayOfTheWeekInactive = Color(0xff3996c0);

  static const dayOfTheWeekActive = white;

  static const titleText = Color(0xff60cdff);

  static const selectorTitleText = Color(0xffc4c4c4);

  static const white = Color(0xffffffff);

  static const timeAgoColorList = [
    Color(0xff3bc0e5),
    Color(0xff389fcb),
    Color(0xff0085be),
    Color(0xffc6333c),
    Color(0xff792242),
    Color(0xff26021a)
  ];

  static const homeBackroundColorList = [Color(0xff3bc0e5), Color(0xff258BA7)];

  static final appBarTextColorList = [
    white.withOpacity(0.6),
    white.withOpacity(0.294)
  ];

  static const onboardingMedCaseColorList = [
    Color(0xff6E7CFA),
    Color(0xff65659C)
  ];

  static const onboardingAddMedsColorList = [
    Color(0xff2B6BAB),
    Color(0xff43A1CB)
  ];

  static const onboardingTakeNotesColorList = [
    Color(0xff6F7CF8),
    Color(0xffF5B127),
  ];

  static const onboardingLastBoardColorList = [
    Color(0xff3BC0E5),
    Color(0xff258BA7),
  ];

  static final appBarTextGr = LinearGradient(
      colors: appBarTextColorList,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);

  static const homeBackgroundGr = LinearGradient(
      colors: AppColors.homeBackroundColorList,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static const onboardingColorsGrList = [
    onboardingMedCaseColorList,
    onboardingAddMedsColorList,
    onboardingTakeNotesColorList,
    onboardingLastBoardColorList
  ];
}
