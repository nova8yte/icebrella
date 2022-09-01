import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

CustomTransition get myCustomTransition => CustomTransition(
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: animation,
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.00,
                    0.50,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: child,
            ),
          ),
        );
      },
    );
