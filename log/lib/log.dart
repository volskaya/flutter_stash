library log;

import 'package:logger/logger.dart';

/// Easy logger constructor.
class Log extends LogPrinter {
  Log._(this.label) : assert(label?.isNotEmpty == true);

  /// Label that's prepended before the log entry.
  final String label;

  /// Creates a labeled [Log].
  static Logger named(String label) => Logger(printer: Log._(label));

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];

    return [
      color('$emoji $label: ${event.message}'),
    ];
  }
}
