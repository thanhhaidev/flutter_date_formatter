/// This class contains the utility methods for replacing
/// the numbers and escape pattern in the input string.
class ReplaceUtils {
  ReplaceUtils._();

  /// Replaces the escape pattern in the input string.
  static String replaceEscapePattern(String input) {
    return input
        .replaceAll("'", "''")
        .replaceAll('[', "'")
        .replaceAll(']', "'");
  }

  /// Replaces the ordinal date pattern in the input string.
  static String replaceLocaleOrdinalDatePattern(
    String input,
    String localeOrdinal,
  ) {
    var matches = _matchesOrdinalDatePattern(input);
    var pattern = input;

    while (matches.isNotEmpty) {
      final match = matches.first;
      pattern = pattern.replaceRange(
        match.start,
        match.end,
        'd${localeOrdinal.isNotEmpty ? "'$localeOrdinal'" : ''}',
      );
      matches = _matchesOrdinalDatePattern(pattern);
    }
    return pattern;
  }

  static List<Match> _matchesOrdinalDatePattern(String input) {
    return RegExp(''''[^']*'|(do)''')
        .allMatches(input)
        .where((match) => match.group(1) == 'do')
        .toList();
  }
}
