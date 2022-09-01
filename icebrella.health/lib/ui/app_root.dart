import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icebrella_health/bloc/home/home_bloc.dart';
import 'package:icebrella_health/bloc/logs/logs_bloc.dart';
import 'package:icebrella_health/bloc/meds/meds_bloc.dart';
import 'package:icebrella_health/values/style/colors.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => MedsBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => LogsBloc(),
        )
      ],
      child: MaterialApp.router(
        title: 'Icebrella',
        locale: const Locale('en', 'US'),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: AppColors.background,
              elevation: 0,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
