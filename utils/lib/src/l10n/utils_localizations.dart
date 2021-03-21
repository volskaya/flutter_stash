
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'utils_localizations_en.dart';
import 'utils_localizations_lv.dart';

/// Callers can lookup localized strings with an instance of UtilsLocalizations returned
/// by `UtilsLocalizations.of(context)`.
///
/// Applications need to include `UtilsLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/utils_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: UtilsLocalizations.localizationsDelegates,
///   supportedLocales: UtilsLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the UtilsLocalizations.supportedLocales
/// property.
abstract class UtilsLocalizations {
  UtilsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static UtilsLocalizations? of(BuildContext context) {
    return Localizations.of<UtilsLocalizations>(context, UtilsLocalizations);
  }

  static const LocalizationsDelegate<UtilsLocalizations> delegate = _UtilsLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('lv')
  ];

  /// No description provided for @soon.
  ///
  /// In en, this message translates to:
  /// **'Soon'**
  String get soon;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @weekdayWithDate.
  ///
  /// In en, this message translates to:
  /// **'{weekday}, {date}'**
  String weekdayWithDate(DateTime weekday, DateTime date);

  /// No description provided for @durationAgo.
  ///
  /// In en, this message translates to:
  /// **'{duration} ago'**
  String durationAgo(Object duration);

  /// No description provided for @remainingDuration.
  ///
  /// In en, this message translates to:
  /// **'{minutes}:{seconds}'**
  String remainingDuration(Object minutes, Object seconds);

  /// No description provided for @weekdayDate.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String weekdayDate(DateTime date);

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String date(DateTime date);

  /// No description provided for @textualDate.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String textualDate(DateTime date);

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String time(DateTime time);

  /// No description provided for @createDate.
  ///
  /// In en, this message translates to:
  /// **'{date} {time}'**
  String createDate(DateTime date, DateTime time);

  /// No description provided for @durationDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} =other{{count} days}}'**
  String durationDays(int count);

  /// No description provided for @durationHours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour} =other{{count} hours}}'**
  String durationHours(int count);

  /// No description provided for @durationHoursTail.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{, 1 hour} =other{, {count} hours}}'**
  String durationHoursTail(int count);

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 min} =other{{count} min}}'**
  String durationMinutes(int count);

  /// No description provided for @durationMinutesTail.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{, 1 min} =other{, {count} min}}'**
  String durationMinutesTail(int count);

  /// No description provided for @durationSeconds.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 second} =other{{count} seconds}}'**
  String durationSeconds(int count);

  /// No description provided for @durationSecondsTail.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{, 1 second} =other{, {count} seconds}}'**
  String durationSecondsTail(int count);

  /// No description provided for @durationDaysShort.
  ///
  /// In en, this message translates to:
  /// **'{count}d'**
  String durationDaysShort(Object count);

  /// No description provided for @durationHoursShort.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String durationHoursShort(Object count);

  /// No description provided for @durationHoursTailShort.
  ///
  /// In en, this message translates to:
  /// **', {count}h'**
  String durationHoursTailShort(Object count);

  /// No description provided for @durationMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'{count}min'**
  String durationMinutesShort(Object count);

  /// No description provided for @durationMinutesTailShort.
  ///
  /// In en, this message translates to:
  /// **', {count}min'**
  String durationMinutesTailShort(Object count);

  /// No description provided for @durationSecondsShort.
  ///
  /// In en, this message translates to:
  /// **'{count}s'**
  String durationSecondsShort(Object count);

  /// No description provided for @durationSecondsTailShort.
  ///
  /// In en, this message translates to:
  /// **', {count}s'**
  String durationSecondsTailShort(Object count);
}

class _UtilsLocalizationsDelegate extends LocalizationsDelegate<UtilsLocalizations> {
  const _UtilsLocalizationsDelegate();

  @override
  Future<UtilsLocalizations> load(Locale locale) {
    return SynchronousFuture<UtilsLocalizations>(_lookupUtilsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'lv'].contains(locale.languageCode);

  @override
  bool shouldReload(_UtilsLocalizationsDelegate old) => false;
}

UtilsLocalizations _lookupUtilsLocalizations(Locale locale) {
  


// Lookup logic when only language code is specified.
switch (locale.languageCode) {
  case 'en': return UtilsLocalizationsEn();
    case 'lv': return UtilsLocalizationsLv();
}


  throw FlutterError(
    'UtilsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
