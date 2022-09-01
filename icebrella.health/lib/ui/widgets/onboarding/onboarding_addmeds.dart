import 'package:flutter/material.dart';
import 'package:icebrella_health/values/style/colors.dart';
import 'package:icebrella_health/values/style/icons.dart';

class OnboardingAddMeds extends StatelessWidget {
  const OnboardingAddMeds({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 144),
            const Flexible(
              child: Text(
                "Добавляй лекарства",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 54),
                child: Image.asset(
                  'assets/images/pill.png',
                  height: 336,
                  width: 320,
                )),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.5),
                    color: Colors.white),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Фемостон 2/10",
                        style: TextStyle(
                            color: AppColors.inContainerText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 7),
                    AppIcons.pen()
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 144,
            ),
          ],
        ),
      ],
    );
  }
}
