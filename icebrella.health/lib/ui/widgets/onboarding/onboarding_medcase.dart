import 'package:flutter/material.dart';
import 'package:icebrella_health/values/style/colors.dart';

class OnboardingMedCase extends StatelessWidget {
  const OnboardingMedCase({Key? key}) : super(key: key);
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
                "Это твой МедКейс",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 54),
              child: Image.asset(
                'assets/images/med_kit.png',
                height: 336,
                width: 320,
              ),
            ),
            const SizedBox(height: 144),
          ],
        ),
      ],
    );
  }
}
