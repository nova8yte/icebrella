import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:icebrella_health/utils/shared_keys.dart';
import 'package:icebrella_health/values/translation/timeago.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart';

class Init {
  static Future initialize() async {
    _setLocaleMessages();
    GetIt.instance.reset();
    GetIt getIt = GetIt.instance;
    await _registerServices(getIt);
    _onboarded();
    _checkAssets();
    //_onLastRoute();
  }

  static _checkAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    if (manifestMap.keys.contains('assets')) {
      _saveAssets(manifestMap['assets'] as Map<String, dynamic>);
    }
  }

  static _saveAssets(Map<String, dynamic> assetsMap) async {
    var icons = assetsMap['icons'];
    if (icons is Map) {}
  }

  static Future _onboarded() async => Modular.to.pushReplacementNamed(
      (GetIt.I<SharedPreferences>().getBool(SharedKeys.finishedOnboarding) ??
              false)
          ? '/home'
          : '/onboarding');

  static _registerServices(GetIt getIt) async {
    var prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);
  }

  static _setLocaleMessages() {
    setLocaleMessages('en_short', CustomEnglish());
  }
}
