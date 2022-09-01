import 'package:flutter_modular/flutter_modular.dart';
import 'package:icebrella_health/ui/screens/about/about_screen.dart';
import 'package:icebrella_health/ui/screens/home_screen.dart';
import 'package:icebrella_health/ui/screens/labs/labs_screen.dart';
import 'package:icebrella_health/ui/screens/logs/logs_screen.dart';
import 'package:icebrella_health/ui/screens/medication/medication_screen.dart';
import 'package:icebrella_health/ui/screens/medication/new_medication_screen.dart';
import 'package:icebrella_health/ui/screens/onboarding/onboarding_screen.dart';
import 'package:icebrella_health/ui/screens/settings/settings_screen.dart';
import 'package:icebrella_health/ui/screens/splash_screen.dart';
import 'package:icebrella_health/values/style/animations/fade_in_transition.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/home', child: (context, args) => HomeScreen()),
        ChildRoute('/', child: (context, args) => const SplashScreen()),
        ChildRoute('/onboarding',
            child: (context, args) => const OnboardingScreen()),
        ChildRoute('/settings',
            child: (context, args) => const SettingsScreen(),
            customTransition: myCustomTransition),
        ChildRoute('/medication',
            child: (context, args) => const MedicationScreen()),
        ChildRoute('/medication/new',
            child: ((context, args) => NewMedicationScreen()),
            customTransition: myCustomTransition),
        ChildRoute('/logs', child: (context, args) => const LogsScreen()),
        ChildRoute('/labs', child: (context, args) => const LabsScreen()),
        ChildRoute('/about', child: (context, args) => const AboutScreen())
      ];
}
