import 'package:get_it/get_it.dart';
import 'package:icebrella_health/entity/translation/gender.dart';

abstract class IntlKey {
  final String key;
  String value;
  IntlKey(this.key, Map<String, dynamic> keys) : value = _read(key, keys);

  static String _read(String key, Map<String, dynamic> keys) {
    throwIfNot(keys.containsKey(key), Exception('Key $key not found'));
    return keys[key] as String;
  }
}

class ReadKey extends IntlKey {
  ReadKey(String key, Map<String, dynamic> keys) : super(key, keys);
}

class CountKey extends IntlKey {
  final int count;
  static const String _template = '{ { count } }';
  CountKey(String key, Map<String, dynamic> keys, this.count)
      : super(key, keys) {
    value = _count(value, count);
  }
  static String _count(String value, count) =>
      value.replaceAll(_template, count);
}

class GenderKey extends IntlKey {
  final GenderSelector genderSelector;
  static const String _template = '{ { gender } }';
  GenderKey(String key, Map<String, dynamic> keys, this.genderSelector)
      : super(key, keys);

  String gender(Type genderType) {
    String? sentence = genderSelector.select(genderType).sentence;
    throwIf(sentence == null, Exception('sentence is null'));
    return value.replaceAll(_template, sentence!);
  }

  String pronouns(Type genderType) =>
      value.replaceAll(_template, genderSelector.select(genderType).pronouns);
}

extension IntlKeySelector on IntlKey {
  static ReadKey read(String key, Map<String, dynamic> keys) =>
      ReadKey(key, keys);
  static CountKey count(String key, Map<String, dynamic> keys, int count) =>
      CountKey(key, keys, count);
  static GenderKey gender(String key, Map<String, dynamic> keys,
          GenderSelector genderSelector) =>
      GenderKey(key, keys, genderSelector);
}
