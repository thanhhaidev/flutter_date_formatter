/// This class contains the utility methods for replacing
/// the numbers and escape pattern in the input string.
class ReplaceUtils {
  ReplaceUtils._();

  /// Converts the package's literal syntax to an `intl` pattern.
  ///
  /// Two literal syntaxes are supported:
  /// - `[text]`, where every character, including `'`, is literal;
  /// - `'text'` as in `intl`, where `''` is a literal apostrophe.
  ///
  /// A literal that is never closed runs to the end of the pattern.
  static String replaceEscapePattern(String input) {
    final output = StringBuffer();
    var inBracket = false;
    var inQuote = false;

    for (var i = 0; i < input.length; i++) {
      final char = input[i];
      if (inBracket) {
        if (char == ']') {
          output.write("'");
          inBracket = false;
        } else {
          output.write(char == "'" ? "''" : char);
        }
      } else if (inQuote) {
        if (char == "'" && i + 1 < input.length && input[i + 1] == "'") {
          output.write("''");
          i++;
        } else {
          output.write(char);
          if (char == "'") inQuote = false;
        }
      } else if (char == '[') {
        output.write("'");
        inBracket = true;
      } else if (char == "'") {
        output.write("'");
        inQuote = true;
      } else {
        output.write(char);
      }
    }

    if (inBracket || inQuote) output.write("'");
    return output.toString();
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
    // A quoted section that is never closed runs to the end of the pattern,
    // so `do` inside it stays literal.
    return RegExp(r"'[^']*(?:'|$)|(do)")
        .allMatches(input)
        .where((match) => match.group(1) == 'do')
        .toList();
  }
}
