import 'package:icebrella_health/entity/translation/gender.dart';
import 'package:icebrella_health/entity/translation/intl_key.dart';
import 'package:icebrella_health/entity/translation/intl_keys.dart';

class AppStrings {
  AppStrings._();
  static const String appName = 'Flutter Demo';
  static const String welcomeUser = '';
}

// Translator with singleton
class Translator {
  Translator._internal() : _keys = readKeys();
  Translator._withKeys(IntlKeys? keys) : _keys = keys ?? readKeys();

  final IntlKeys _keys;

  IntlKeys get keys => _keys;

  static final Translator _instance = Translator._internal();

  factory Translator({IntlKeys? keys}) {
    return keys == null ? _instance : Translator._withKeys(keys);
  }

  static IntlKeys readKeys() {
    return IntlKeys(Map());
  }
}

extension TranslationExtension on String {
  String countTr(int count) => '$tr ($count)';
  // xaxa
  String genderTr(Gender gender) =>
      IntlKeySelector.gender(welcomeUser, keys, isMale).value;
}
