import 'package:icebrella_health/entity/translation/gender.dart';
import 'package:icebrella_health/entity/translation/intl_key.dart';

class IntlKeys {
  final Map<String, dynamic> mapKeys;
  IntlKeys(this.mapKeys);

  ReadKey read(String key) => IntlKeySelector.read(key, mapKeys);

  CountKey count(String key, int count) =>
      IntlKeySelector.count(key, mapKeys, count);

  GenderKey gender(String key, Map<String, dynamic> keys,
          GenderSelector genderSelector) =>
      IntlKeySelector.gender(key, keys, genderSelector);
}
