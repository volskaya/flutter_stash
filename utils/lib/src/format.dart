import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quiver/strings.dart';
import 'package:utils/src/mixins.dart';

import 'enums.dart';

enum DateSkeleton {
  // ignore:constant_identifier_names
  yMd_jm, // 06/22/2020 2:57 PM
  yMd, // 06/22/2020
  jm, // 9:30 PM
  // ignore:constant_identifier_names
  EEEE, // Day full name
  yMMMd, // 22 Jun 2020
  keyboard,
}

class Format {
  static final _dateFormatters = <String, Map<DateSkeleton, DateFormat>>{};

  static String currencyString(double amount) => '€ ${amount.toStringAsFixed(2)}';
  static String coinAsCurrency(int coin) => currencyString(coin / 100);

  static String errorMessage(String message) {
    if (isEmpty(message)) return null;
    if (message.length == 1) return message.toUpperCase();
    return Format.capitalize(message).replaceAll('-', ' ');
  }

  static String platformExceptionMessage(PlatformException exception) =>
      errorMessage((exception?.details as Map ?? {})['message'] as String ?? 'Unknown error');

  static String firebaseFunctionsErrorMessage(FirebaseFunctionsException exception) =>
      errorMessage(exception?.message ?? 'Unknown error');

  static String userName([TitledModel user]) {
    if (user == null) return 'Untitled';
    if (isNotEmpty(user.title)) return user.title;
    return 'Usr. ${user.id.substring(0, 6)}';
  }

  static String getPronoun(Gender gender, {bool capitalize = false}) {
    String str;
    switch (gender) {
      case Gender.male:
        str = 'his';
        break;
      case Gender.female:
        str = 'her';
        break;
      default:
        return null;
    }
    return str != null
        ? capitalize
            ? Format.capitalize(str)
            : str
        : null;
  }

  static String capitalize(String str) =>
      str.length > 1 ? '${str[0].toUpperCase()}${str.substring(1)}' : str.toUpperCase();

  static String counted(
    int count,
    String name, {
    bool upperCase = false,
    String singularSuffix = '',
    String pluralSuffix = 's',
    String countAlternative,
    bool omitNumber = false,
  }) {
    final buffer = StringBuffer();
    if (!omitNumber) {
      buffer.write(countAlternative ?? count);
      buffer.write(' ');
    }
    buffer.write(name);
    buffer.write(count == 1 ? singularSuffix : pluralSuffix);

    final str = buffer.toString();
    return upperCase ? str.toUpperCase() : str;
  }

  /// Returns a memoized [DateFormat] for the used [DateSkeleton].
  static DateFormat dateFormatOf([
    DateSkeleton skeleton = DateSkeleton.yMd,
  ]) {
    _dateFormatters['en'] ??= <DateSkeleton, DateFormat>{};
    if (!_dateFormatters['en'].containsKey(skeleton)) {
      switch (skeleton) {
        case DateSkeleton.yMd_jm:
          _dateFormatters['en'][skeleton] = DateFormat.yMd().add_jm();
          break;
        case DateSkeleton.keyboard:
        case DateSkeleton.yMd:
          _dateFormatters['en'][skeleton] = DateFormat.yMd();
          break;
        case DateSkeleton.jm:
          _dateFormatters['en'][skeleton] = DateFormat.jm();
          break;
        case DateSkeleton.EEEE:
          _dateFormatters['en'][skeleton] = DateFormat.EEEE();
          break;
        case DateSkeleton.yMMMd:
          _dateFormatters['en'][skeleton] = DateFormat.yMMMd();
          break;
        default:
          throw UnimplementedError();
      }
    }

    return _dateFormatters['en'][skeleton];
  }

  static String duration(Duration _duration) {
    // Don't print duration under 0.
    final duration = _duration >= Duration.zero ? _duration : Duration.zero;
    final buffer = StringBuffer();

    if (duration.inHours >= Duration.hoursPerDay) {
      buffer.write(Format.counted(duration.inDays, 'day'));
      final remainder = duration.inHours % Duration.hoursPerDay;

      if (remainder > 0) {
        buffer.write(', ${Format.counted(remainder.round(), "hour")}');
      }
    } else if (duration.inMinutes >= Duration.minutesPerHour) {
      buffer.write(Format.counted(duration.inHours, 'hour'));
      final remainder = duration.inMinutes % Duration.minutesPerHour;

      if (remainder > 0) {
        buffer.write(', ${remainder.round()} min');
      }
    } else if (duration.inSeconds >= Duration.secondsPerMinute) {
      buffer.write('${duration.inMinutes.round()} min');
    } else {
      buffer.write(Format.counted(duration.inSeconds, 'second'));
    }

    return buffer.toString();
  }

  static String remainingDuration(Duration duration) {
    assert(duration.inHours == 0);
    if (duration < Duration.zero) return 'Soon';
    return '${duration.inMinutes.toString().padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}';
  }

  static String date(
    DateTime date, {
    DateTime anchor,
    bool useWords = false,
    bool prependDay = false,
  }) {
    final now = anchor ?? DateTime.now();
    String string;

    if (useWords) {
      // NOTE: +1 hour safe zone
      if (date.isAfter(now.subtract(const Duration(hours: 24)))) {
        return 'Today';
      } else if (date.isAfter(now.subtract(const Duration(hours: 32)))) {
        return 'Yesterday';
      }
    }

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      string = Format.dateFormatOf(DateSkeleton.EEEE).format(date);
    } else {
      string = Format.dateFormatOf().format(date);
    }

    return prependDay ? '${Format.dateFormatOf(DateSkeleton.EEEE).format(date)}, $string' : string;
  }

  static final _redundantNewLineRegExp = RegExp(r'\n+');
  static final _defaultCreateTimeFormat = Format.dateFormatOf(DateSkeleton.yMd_jm);
  static String trimRedundantLines(String str) => str.replaceAll(_redundantNewLineRegExp, '\n');

  static String createTime(DateTime time, [DateFormat format]) {
    final formatter = format ?? _defaultCreateTimeFormat;
    final duration = time != null ? DateTime.now().difference(time) : Duration.zero;
    if (duration < Duration.zero) return 'Just now';
    return duration > const Duration(days: 1) ? formatter.format(time) : '${Format.duration(duration)} ago';
  }
}
