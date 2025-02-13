/// This is the abstract class for relative date time
abstract class RelativeDateTime {
  /// Returns the prefix for the "ago" relative date time.
  String prefixAgo();

  /// Returns the prefix for the "from now" relative date time.
  String prefixFromNow();

  /// Returns the suffix for the "ago" relative date time.
  String suffixAgo();

  /// Returns the suffix for the "from now" relative date time.
  String suffixFromNow();

  /// Returns the relative date time for less than one minute.
  String lessThanOneMinute(int seconds);

  /// Returns the relative date time for about a minute.
  String aboutAMinute(int minutes);

  /// Returns the relative date time for minutes.
  String minutes(int minutes);

  /// Returns the relative date time for about an hour.
  String aboutAnHour(int minutes);

  /// Returns the relative date time for hours.
  String hours(int hours);

  /// Returns the relative date time for a day.
  String aDay(int hours);

  /// Returns the relative date time for days.
  String days(int days);

  /// Returns the relative date time for about a month.
  String aboutAMonth(int days);

  /// Returns the relative date time for months.
  String months(int months);

  /// Returns the relative date time for about a year.
  String aboutAYear(int year);

  /// Returns the relative date time for years.
  String years(int years);

  /// Returns the word separator.
  String wordSeparator();
}
