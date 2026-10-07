/// Locale strings for calendar-style formatting, such as "Today at 3:00 PM"
/// or "Last Monday at 3:00 PM".
///
/// `time` is the time already formatted for the locale (for example
/// `3:00 PM` or `15:00`). `weekday` is the weekday name of `date` from the
/// `intl` data; locales that inflect weekday names can build their own from
/// `date` instead. `isSameWeek` tells whether `date` falls in the same
/// calendar week as today (using the locale's first day of the week), for
/// languages that word "this Monday" and "last/next Monday" differently.
abstract class CalendarDateTime {
  /// A time later or earlier today, e.g. "Today at 3:00 PM".
  String sameDay(String time);

  /// A time tomorrow, e.g. "Tomorrow at 3:00 PM".
  String nextDay(String time);

  /// A time yesterday, e.g. "Yesterday at 3:00 PM".
  String lastDay(String time);

  /// A time 2 to 6 days ahead, e.g. "Monday at 3:00 PM".
  String nextWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  });

  /// A time 2 to 6 days ago, e.g. "Last Monday at 3:00 PM".
  String lastWeek(
    DateTime date,
    String weekday,
    String time, {
    bool isSameWeek = false,
  });
}
