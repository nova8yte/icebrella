import 'package:flutter/material.dart';
import 'package:icebrella_health/values/style/colors.dart';

class SettingsItemBtn extends StatelessWidget {
  const SettingsItemBtn({
    Key? key,
    required this.text,
    required this.iconData,
    this.onPressed,
  })  : isActive = onPressed != null,
        super(key: key);

  final String text;
  final IconData iconData;
  final VoidCallback? onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Color color =
        isActive ? AppColors.white : AppColors.dayOfTheWeekInactive;
    return MaterialButton(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 9),
                  Text(text, style: const TextStyle(color: AppColors.white)),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
                size: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
