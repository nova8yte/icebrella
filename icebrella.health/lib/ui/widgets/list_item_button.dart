import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';

class ListItemButton extends StatelessWidget {
  final String text;
  final FlatIcon icon;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool active;
  final Color iconContainerColor;
  final int itemsAmount;
  const ListItemButton(this.text,
      {Key? key,
      required this.icon,
      this.active = true,
      this.onPressed,
      this.onLongPress,
      this.iconContainerColor = AppColors.buttonHomeText,
      this.itemsAmount = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: AppColors.buttonHomeActive,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          padding: const EdgeInsets.only(left: 25, right: 8, top: 7, bottom: 7),
          child: Badge(
            padding: const EdgeInsets.all(6),
            showBadge: itemsAmount > 0,
            badgeColor: AppColors.buttonHomeText,
            badgeContent: Text(itemsAmount.toString(),
                style: const TextStyle(color: Colors.white)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: active
                            ? AppColors.buttonHomeText
                            : AppColors.buttonHomeText.withOpacity(0.30))),
                Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: active
                          ? iconContainerColor
                          : iconContainerColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(44),
                    ),
                    height: 100,
                    width: 100,
                    child: icon),
              ],
            ),
          ),
          onPressed: active ? onPressed : null),
    );
  }
}
