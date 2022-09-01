import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Text("About",
                    style: TextStyle(
                        color: AppColors.appBarIcon,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Align(
              alignment:
                  Alignment.lerp(Alignment.topLeft, Alignment.center, 0.5) ??
                      Alignment.center,
              child: AppIcons.logo(
                  color: AppColors.buttonHomeText.withOpacity(0.1))),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
