/// Locale strings for the units of a humanized [Duration], such as
/// "2 hours 5 minutes".
///
/// Each method receives the count and returns the standalone (nominative)
/// form, including the number, e.g. `hours(2)` → "2 hours".
abstract class DurationUnits {
  /// e.g. "5 seconds".
  String seconds(int seconds);

  /// e.g. "5 minutes".
  String minutes(int minutes);

  /// e.g. "5 hours".
  String hours(int hours);

  /// e.g. "5 days".
  String days(int days);

  /// e.g. "5 weeks".
  String weeks(int weeks);

  /// The text between two units, e.g. " " or ", ".
  String delimiter();
}
