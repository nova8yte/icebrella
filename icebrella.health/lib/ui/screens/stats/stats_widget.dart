import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icebrella_health/values/style/colors.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      color: AppColors.background,
      constraints: BoxConstraints.tight(MediaQuery.of(context).size),
      child: const Center(
        child: Text(
          "Stats",
        ),
      ),
    );
  }
}
