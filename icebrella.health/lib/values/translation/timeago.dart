import 'package:timeago/timeago.dart';

class CustomEnglish extends EnMessages {
  @override
  String lessThanOneMinute(int seconds) => 'moment';
  @override
  String prefixFromNow() => 'in';
  @override
  String suffixFromNow() => '';
  @override
  String aboutAMinute(minutes) => 'minute';
  @override
  String aboutAnHour(minutes) => 'hour';
  @override
  String aboutAMonth(days) => 'month';
  @override
  String prefixAgo() => '';
  @override
  String suffixAgo() => 'ago';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String hours(int hours) => '${hours}h';
  @override
  String aDay(int hours) => 'day';
  @override
  String days(int days) => '${days}days';
  @override
  String months(int months) => '${months}months';
  @override
  String aboutAYear(int year) => 'year';
  @override
  String years(int years) => '${years}years';
  @override
  String wordSeparator() => ' ';
}
