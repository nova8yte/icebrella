import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icebrella_health/values/style/colors.dart';

class OnboardingTakeNotes extends StatelessWidget {
  const OnboardingTakeNotes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 144),
            thermometer,
            const Flexible(
              child: Text(
                "Записывай свое состояние",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
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
                child: const Text("🤧    🤢    😪",
                    style: TextStyle(
                        color: AppColors.inContainerText,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 144),
          ],
        ),
      ],
    );
  }

  Widget get thermometer => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 54),
        child: Image.asset(
          'assets/images/thermometer.png',
          height: 336,
          width: 320,
        ),
      );
}
