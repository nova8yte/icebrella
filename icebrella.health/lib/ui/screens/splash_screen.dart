import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icebrella_health/init.dart';
import 'package:icebrella_health/values/style/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonore',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.background,
            elevation: 0,
          )),
      home: FutureBuilder(
        future: Init.initialize(),
        builder: (context, snapshot) {
          Widget loading = (snapshot.connectionState == ConnectionState.done)
              ? const SizedBox()
              : const CircularProgressIndicator();

          return Scaffold(
              body: Center(
                  child: SizedBox(height: 35, width: 35, child: loading)));
        },
      ),
    );
  }
}
