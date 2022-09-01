import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:icebrella_health/ui/app_root.dart';
import 'package:icebrella_health/values/routes/app_module.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBlocOverrides.runZoned(
    () => runApp(ModularApp(module: AppModule(), child: const AppRoot())),
    storage: await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory(),
    ),
  );
}
