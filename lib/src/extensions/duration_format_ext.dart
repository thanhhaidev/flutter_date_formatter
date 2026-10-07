import 'package:flutter_date_formatter/src/enums/unit.dart';
import 'package:flutter_date_formatter/src/flutter_date_formatter.dart';

/// Extension methods for formatting [Duration] objects.
extension DurationFormatExtensions on Duration {
  /// Formats the Duration as text such as "2 hours 5 minutes", or "2h 5m"
  /// when [short] is `true`.
  ///
  /// See [FlutterDateFormatter.formatDuration].
  String humanize({
    String? locale,
    bool short = false,
    int maxUnits = 2,
    Unit largestUnit = Unit.day,
    Unit smallestUnit = Unit.second,
    String? delimiter,
  }) {
    return FlutterDateFormatter.formatDuration(
      this,
      locale: locale,
      short: short,
      maxUnits: maxUnits,
      largestUnit: largestUnit,
      smallestUnit: smallestUnit,
      delimiter: delimiter,
    );
  }
}
