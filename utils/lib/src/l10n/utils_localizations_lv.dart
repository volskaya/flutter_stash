
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'utils_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for Latvian (`lv`).
class UtilsLocalizationsLv extends UtilsLocalizations {
  UtilsLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get soon => 'Drīz';

  @override
  String get today => 'Šodien';

  @override
  String get yesterday => 'Vakar';

  @override
  String get justNow => 'Tik tiko';

  @override
  String weekdayWithDate(DateTime weekday, DateTime date) {
    final intl.DateFormat weekdayDateFormat = intl.DateFormat.EEEE(localeName);
    final String weekdayString = weekdayDateFormat.format(weekday);
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '${weekdayString}, ${dateString}';
  }

  @override
  String durationAgo(Object duration) {
    return '${duration} atpakaļ';
  }

  @override
  String remainingDuration(Object minutes, Object seconds) {
    return '${minutes}:${seconds}';
  }

  @override
  String weekdayDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.EEEE(localeName);
    final String dateString = dateDateFormat.format(date);

    return '${dateString}';
  }

  @override
  String date(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '${dateString}';
  }

  @override
  String createDate(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '${dateString} ${timeString}';
  }

  @override
  String durationDays(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 dienu',
      other: '${count} dienas',
    );
  }

  @override
  String durationHours(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 stundu',
      other: '${count} stundas',
    );
  }

  @override
  String durationHoursTail(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: ', 1 stundu',
      other: ', ${count} stundas',
    );
  }

  @override
  String durationMinutes(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 min',
      other: '${count} min',
    );
  }

  @override
  String durationMinutesTail(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: ', 1 min',
      other: ', ${count} min',
    );
  }

  @override
  String durationSeconds(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '1 sekundi',
      other: '${count} sekundes',
    );
  }

  @override
  String durationSecondsTail(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: ', 1 seskundi',
      other: ', ${count} sekundes',
    );
  }
}
