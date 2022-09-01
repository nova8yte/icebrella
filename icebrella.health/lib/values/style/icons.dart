// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icebrella_health/values/style/colors.dart';

class AppIcons {
  static FlatIcon tablet = FlatIcon("tablet_horizontal.svg",
      iconName: 'No Meds Icon', width: 286, height: 141, fit: BoxFit.contain);

  static tablet_rotated(
          {double width = 20, double height = 40, Color? color}) =>
      FlatIcon("tablet_45deg.svg",
          iconName: 'Meds Icon',
          width: 20,
          height: 40,
          color: color,
          fit: BoxFit.contain);

  static FlatIcon more({double width = 32, double height = 8, Color? color}) =>
      FlatIcon("more.svg",
          iconName: 'Meds Icon',
          width: 20,
          height: 40,
          color: color,
          fit: BoxFit.contain);

  // With Active state

  static user_circle({bool active = false}) => FlatIcon(
        "user-circle.svg",
        iconName: 'User profile Icon',
        color: AppColors.inactiveIcon,
        activeColor: AppColors.activeIcon,
        activeHeight: 40,
        activeWidth: 40,
        isActive: active,
      );

  static estate({bool active = false}) => FlatIcon(
        "estate.svg",
        iconName: 'Estate icon',
        isActive: active,
      );

  static chart({double width = 36, double height = 36, Color? color}) =>
      FlatIcon("chart.svg",
          iconName: 'Chart icon', color: AppColors.inactiveIcon);

  static bell({bool active = false}) => FlatIcon(
        "bell.svg",
        iconName: 'Bell icon',
        isActive: active,
      );

  static settings({bool active = false}) => FlatIcon(
        "settings.svg",
        iconName: 'Settings icon',
        isActive: active,
      );

  static final heart_medical =
      FlatIcon("heart-medical.svg", iconName: 'Heart Medical icon');

  static final moon = FlatIcon("moon.svg", iconName: 'Moon icon');

  static final sun = FlatIcon("sun.svg", iconName: 'Sun icon');

  static final sunset = FlatIcon("sunset.svg", iconName: 'Sunset Icon');

  static final plus =
      FlatIcon("plus.svg", iconName: 'Add Logs Icon', width: 35, height: 35);

  static FlatIcon clipboard(
          {double width = 36, double height = 36, Color? color}) =>
      FlatIcon(
        "assets/icons/clipboard.svg",
        iconName: 'Logs Icon',
        width: width,
        height: height,
        color: color,
      );
  static FlatIcon flask(
          {double width = 36, double height = 36, Color? color}) =>
      FlatIcon(
        "flask.svg",
        iconName: 'Labs Icon',
        width: width,
        height: height,
        color: color,
      );
  static FlatIcon doctor(
          {double width = 36, double height = 36, Color? color}) =>
      FlatIcon(
        "doctor.svg",
        iconName: 'Upcoming Feature Icon',
        width: width,
        height: height,
        color: color,
      );
  static FlatIcon pen({double width = 15, double height = 15, Color? color}) =>
      FlatIcon(
        "pen.svg",
        iconName: 'Edit Icon',
        width: width,
        height: height,
        color: color,
      );

  static FlatIcon syringe_big(
          {double width = 128, double height = 128, Color? color}) =>
      FlatIcon(
        "syringe-big.svg",
        iconName: 'Syringe Icon',
        width: width,
        height: height,
        color: color,
      );

  static FlatIcon pill_small(
          {double width = 42, double height = 42, Color? color}) =>
      FlatIcon(
        "pill-small.svg",
        iconName: 'Pill Icon',
        width: width,
        height: height,
        color: color,
      );

  static FlatIcon syringe_small(
          {double width = 42, double height = 42, Color? color}) =>
      FlatIcon(
        "syringe-small.svg",
        iconName: 'Syringe Icon',
        width: width,
        height: height,
        color: color,
      );

  static FlatIcon tablets_small(
          {double width = 42, double height = 42, Color? color}) =>
      FlatIcon(
        "tablets-small.svg",
        iconName: 'Tablets Icon',
        width: width,
        height: height,
        color: color,
      );

  static FlatIcon icon_back(
          {double width = 30,
          double height = 30,
          Color? color = Colors.white}) =>
      FlatIcon(
        "icon-back.svg",
        iconName: 'Icon Back',
        width: width,
        height: height,
        color: color,
      );

  static FlatIcon logo(
          {double width = 188, double height = 213, Color? color}) =>
      FlatIcon(
        "logo.svg",
        iconName: 'Logo',
        width: width,
        height: height,
        color: color,
      );

  static FlatIcon arrow_right(
          {double width = 50, double height = 50, Color? color}) =>
      FlatIcon(
        "arrow_right.svg",
        iconName: 'Arrow right',
        width: width,
        height: height,
        color: color,
      );

  // Active
  static final user_circle_active = FlatIcon("user-circle.svg",
      height: 36, width: 36, iconName: 'User profile Icon');

  static final estate_active = FlatIcon("estate.svg",
      height: 36, width: 36, iconName: 'Active Estate icon');

  static final chart_active = FlatIcon("chart.svg",
      height: 36, width: 36, iconName: 'Active Chart icon');

  static final bell_active =
      FlatIcon("bell.svg", height: 36, width: 36, iconName: 'Active Bell icon');

  static final settings_active = FlatIcon("settings.svg",
      height: 36, width: 36, iconName: 'Active Settings icon');
}

class FlatIcon extends StatelessWidget {
  final String icon;
  final String? iconName;
  Color? color;
  Color? activeColor;

  final bool isActive;

  final double width;
  final double height;
  final double? activeWidth;
  final double? activeHeight;
  final BoxFit? fit;
  static const String _basepath = "assets/icons/";

  FlatIcon(
    this.icon, {
    Key? key,
    this.width = 36,
    this.height = 36,
    double? activeWidth,
    double? activeHeight,
    this.iconName,
    this.activeColor,
    this.color = AppColors.white,
    this.fit,
    this.isActive = false,
  })  : activeWidth = isActive ? activeWidth ?? width : width,
        activeHeight = isActive ? activeHeight ?? height : height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      color = AppColors.activeIcon;
    }
    return SvgPicture.asset(
      _basepath + icon,
      semanticsLabel: iconName ?? icon,
      width: activeWidth ?? width,
      height: activeHeight ?? height,
      color: isActive ? activeColor : color,
      fit: fit ?? BoxFit.contain,
    );
  }
}
