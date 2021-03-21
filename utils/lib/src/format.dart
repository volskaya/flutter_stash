import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:quiver/strings.dart';
import 'package:utils/src/l10n/utils_localizations.dart';
import 'package:utils/src/mixins.dart';

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

  static String? errorMessage(String message) {
    if (isEmpty(message)) return null;
    if (message.length == 1) return message.toUpperCase();
    return Format.capitalize(message).replaceAll('-', ' ');
  }

  static String? platformExceptionMessage(PlatformException exception, {String orElse = '???'}) =>
      errorMessage((exception.details)['message'] as String? ?? orElse);

  static String? firebaseFunctionsErrorMessage(FirebaseFunctionsException exception, {String orElse = '???'}) =>
      errorMessage(exception.message ?? orElse);

  static String userName([UserModel? user]) {
    if (user == null) return '???';
    if (user.banTime == null && isNotEmpty(user.title)) return user.title!;
    return '${user.id.substring(0, 6)}';
  }

  static String capitalize(String str) =>
      str.length > 1 ? '${str[0].toUpperCase()}${str.substring(1)}' : str.toUpperCase();

  static String counted(
    int count,
    String name, {
    bool upperCase = false,
    String singularSuffix = '',
    String pluralSuffix = 's',
    String? countAlternative,
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
    Locale locale = const Locale('en'),
  ]) {
    final localeTag = locale.toLanguageTag();

    _dateFormatters[localeTag] ??= <DateSkeleton, DateFormat>{};
    if (!_dateFormatters[localeTag]!.containsKey(skeleton)) {
      switch (skeleton) {
        case DateSkeleton.yMd_jm:
          _dateFormatters[localeTag]![skeleton] = DateFormat.yMd().add_jm();
          break;
        case DateSkeleton.keyboard:
        case DateSkeleton.yMd:
          _dateFormatters[localeTag]![skeleton] = DateFormat.yMd();
          break;
        case DateSkeleton.jm:
          _dateFormatters[localeTag]![skeleton] = DateFormat.jm();
          break;
        case DateSkeleton.EEEE:
          _dateFormatters[localeTag]![skeleton] = DateFormat.EEEE();
          break;
        case DateSkeleton.yMMMd:
          _dateFormatters[localeTag]![skeleton] = DateFormat.yMMMd();
          break;
        default:
          throw UnimplementedError();
      }
    }

    return _dateFormatters[localeTag]![skeleton]!;
  }

  static String duration(Duration _duration, [UtilsLocalizations? strings]) {
    // Don't print duration under 0.
    final duration = _duration >= Duration.zero ? _duration : Duration.zero;
    final buffer = StringBuffer();

    if (duration.inHours >= Duration.hoursPerDay) {
      buffer.write(strings?.durationDays(duration.inDays) ?? Format.counted(duration.inDays, 'day'));
      final remainder = duration.inHours % Duration.hoursPerDay;

      if (remainder > 0) {
        buffer.write(strings?.durationHoursTail(remainder) ?? ', ${Format.counted(remainder, "hour")}');
      }
    } else if (duration.inMinutes >= Duration.minutesPerHour) {
      buffer.write(strings?.durationHours(duration.inHours) ?? Format.counted(duration.inHours, 'hour'));
      final remainder = duration.inMinutes % Duration.minutesPerHour;

      if (remainder > 0) {
        buffer.write(strings?.durationMinutesTail(remainder) ?? ', $remainder min');
      }
    } else if (duration.inSeconds >= Duration.secondsPerMinute) {
      buffer.write(strings?.durationMinutes(duration.inMinutes) ?? '${duration.inMinutes} min');
    } else {
      buffer.write(strings?.durationSeconds(duration.inSeconds) ?? Format.counted(duration.inSeconds, 'second'));
    }

    return buffer.toString();
  }

  static String durationShort(Duration _duration, [UtilsLocalizations? strings]) {
    // Don't print duration under 0.
    final duration = _duration >= Duration.zero ? _duration : Duration.zero;
    final buffer = StringBuffer();

    if (duration.inHours >= Duration.hoursPerDay) {
      buffer.write(strings?.durationDaysShort(duration.inDays) ?? Format.counted(duration.inDays, 'day'));
      final remainder = duration.inHours % Duration.hoursPerDay;

      if (remainder > 0) {
        buffer.write(strings?.durationHoursTailShort(remainder) ?? ', ${Format.counted(remainder, "hour")}');
      }
    } else if (duration.inMinutes >= Duration.minutesPerHour) {
      buffer.write(strings?.durationHoursShort(duration.inHours) ?? Format.counted(duration.inHours, 'hour'));
      final remainder = duration.inMinutes % Duration.minutesPerHour;

      if (remainder > 0) {
        buffer.write(strings?.durationMinutesTailShort(remainder) ?? ', $remainder min');
      }
    } else if (duration.inSeconds >= Duration.secondsPerMinute) {
      buffer.write(strings?.durationMinutesShort(duration.inMinutes) ?? '${duration.inMinutes} min');
    } else {
      buffer.write(strings?.durationSecondsShort(duration.inSeconds) ?? Format.counted(duration.inSeconds, 'second'));
    }

    return buffer.toString();
  }

  static String dateShort(DateTime date, [UtilsLocalizations? strings]) {
    final showTimeInstead = DateTime.now().difference(date) < const Duration(days: 1);
    return showTimeInstead
        ? (strings?.time(date) ?? Format.dateFormatOf(DateSkeleton.jm).format(date))
        : (strings?.textualDate(date) ?? Format.dateFormatOf(DateSkeleton.yMMMd).format(date));
  }

  static String remainingDuration(Duration duration, [UtilsLocalizations? strings]) {
    assert(duration.inHours == 0);
    if (duration < Duration.zero) return strings?.soon ?? 'Soon';

    final minutes = duration.inMinutes.toString().padLeft(2, "0");
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, "0");

    return strings?.remainingDuration(minutes, seconds) ?? '$minutes:$seconds';
  }

  static String date(
    DateTime date, {
    DateTime? anchor,
    bool useWords = false,
    bool prependDay = false,
    UtilsLocalizations? strings,
  }) {
    final now = anchor ?? DateTime.now();

    if (useWords) {
      if (date.isAfter(now.subtract(const Duration(hours: 24)))) {
        return strings?.today ?? 'Today';
      } else if (date.isAfter(now.subtract(const Duration(hours: 32)))) {
        return strings?.yesterday ?? 'Yesterday';
      }
    }

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return strings?.weekdayDate(date) ?? Format.dateFormatOf(DateSkeleton.EEEE).format(date);
    } else if (prependDay) {
      return strings?.weekdayWithDate(date, date) ??
          '${Format.dateFormatOf(DateSkeleton.EEEE).format(date)}, ${Format.dateFormatOf().format(date)}';
    }

    return strings?.date(date) ?? Format.dateFormatOf().format(date);
  }

  static final _redundantNewLineRegExp = RegExp(r'\n+');
  static final _defaultCreateTimeFormat = Format.dateFormatOf(DateSkeleton.yMd_jm);
  static String trimRedundantLines(String str) => str.replaceAll(_redundantNewLineRegExp, '\n');

  static String createTime(DateTime? time, [DateFormat? format, UtilsLocalizations? strings]) {
    final duration = time != null ? DateTime.now().difference(time) : Duration.zero;
    if (duration < Duration.zero) {
      return strings?.justNow ?? 'Just now';
    } else if (duration > const Duration(days: 1)) {
      if (strings == null) {
        final formatter = format ?? _defaultCreateTimeFormat;
        return formatter.format(time!);
      }

      return strings.createDate(time!, time);
    } else {
      return strings?.durationAgo(duration) ?? '${Format.duration(duration, strings)} ago';
    }
  }

  /// If the number is higher than 1000, returns it as 1K or 44.2K.
  static String thousand(num number) =>
      number < 1000 ? number.toString() : (number / 1000).toStringAsPrecision(0) + 'k';

  /// Formats price.
  static String price(double price, String? currency, Locale? locale) => NumberFormat.simpleCurrency(
        locale: locale?.languageCode ?? 'en',
        name: currency ?? '',
        decimalDigits: 2,
      ).format(price);
}
