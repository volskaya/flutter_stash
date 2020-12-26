library log;

import 'package:logger/logger.dart';
export 'package:logger/logger.dart' show Level;

/// Easy logger constructor.
class Log extends LogPrinter {
  Log._(this.label) : assert(label?.isNotEmpty == true);

  /// Label that's prepended before the log entry.
  final String label;

  /// Creates a labeled [Log].
  static Logger named(String label) => Logger(printer: Log._(label));

  /// The current logging level of the app.
  ///
  /// All logs with levels below this level will be omitted.
  static Level get level => Logger.level;

  /// The current logging level of the app.
  ///
  /// All logs with levels below this level will be omitted.
  static set level(Level level) => Logger.level = level;

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];

    return [
      color('$emoji $label: ${event.message}'),
    ];
  }
}
