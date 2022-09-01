import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingLastBoard extends StatelessWidget {
  const OnboardingLastBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 144),
              const Flexible(
                child: Text(
                  "Открытый проект",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 44),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "• Вы в центре\n"
                  "• Безопасный\n"
                  "• Без почт и рекламы",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(99)),
                    ),
                    const Flexible(
                      child: Text(
                        "Продолжая вы соглашаетесь с icebrellas.space/agreement",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 144),
            ],
          ),
        ),
      ],
    );
  }
}
