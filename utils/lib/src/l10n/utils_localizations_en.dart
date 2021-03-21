

import 'package:intl/intl.dart' as intl;
import 'utils_localizations.dart';

/// The translations for English (`en`).
class UtilsLocalizationsEn extends UtilsLocalizations {
  UtilsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get soon => 'Soon';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get justNow => 'Just now';

  @override
  String weekdayWithDate(DateTime weekday, DateTime date) {
    final intl.DateFormat weekdayDateFormat = intl.DateFormat.EEEE(localeName);
    final String weekdayString = weekdayDateFormat.format(weekday);
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$weekdayString, $dateString';
  }

  @override
  String durationAgo(Object duration) {
    return '$duration ago';
  }

  @override
  String remainingDuration(Object minutes, Object seconds) {
    return '$minutes:$seconds';
  }

  @override
  String weekdayDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.EEEE(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String date(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String textualDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String time(DateTime time) {
    final intl.DateFormat timeDateFormat = intl.DateFormat.jm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$timeString';
  }

  @override
  String createDate(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString $timeString';
  }

  @override
  String durationDays(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 day',
      other: '$count days',
    );
  }

  @override
  String durationHours(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 hour',
      other: '$count hours',
    );
  }

  @override
  String durationHoursTail(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: ', 1 hour',
      other: ', $count hours',
    );
  }

  @override
  String durationMinutes(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 min',
      other: '$count min',
    );
  }

  @override
  String durationMinutesTail(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: ', 1 min',
      other: ', $count min',
    );
  }

  @override
  String durationSeconds(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 second',
      other: '$count seconds',
    );
  }

  @override
  String durationSecondsTail(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: ', 1 second',
      other: ', $count seconds',
    );
  }

  @override
  String durationDaysShort(Object count) {
    return '${count}d';
  }

  @override
  String durationHoursShort(Object count) {
    return '${count}h';
  }

  @override
  String durationHoursTailShort(Object count) {
    return ', ${count}h';
  }

  @override
  String durationMinutesShort(Object count) {
    return '${count}min';
  }

  @override
  String durationMinutesTailShort(Object count) {
    return ', ${count}min';
  }

  @override
  String durationSecondsShort(Object count) {
    return '${count}s';
  }

  @override
  String durationSecondsTailShort(Object count) {
    return ', ${count}s';
  }
}
