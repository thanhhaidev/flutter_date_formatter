import 'package:flutter_date_formatter/src/models/models.dart';

/// Tagalog Locale
class TlPhLocale extends Locale {
  @override
  String code() => 'tl_PH';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => '$n';

  @override
  RelativeDateTime relativeDateTime() => TlPhRelativeDateTime();

  @override
  RelativeDateTime shortRelativeDateTime() => TlPhShortRelativeDateTime();
}

/// Tagalog relative date time
class TlPhRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'nakalipas';
  @override
  String suffixFromNow() => 'mula ngayon';
  @override
  String lessThanOneMinute(int seconds) => 'isang saglit';
  @override
  String aboutAMinute(int minutes) => 'isang minuto';
  @override
  String minutes(int minutes) => '${_numToWordsFormatter(minutes)} minuto';
  @override
  String aboutAnHour(int minutes) => 'mga isang oras';
  @override
  String hours(int hours) => '${_numToWordsFormatter(hours)} oras';
  @override
  String aDay(int hours) => 'isang araw';
  @override
  String days(int days) => '${_numToWordsFormatter(days)} araw';
  @override
  String aboutAMonth(int days) => 'mga isang buwan';
  @override
  String months(int months) => '${_numToWordsFormatter(months)} buwan';
  @override
  String aboutAYear(int year) => 'mga isang taon';
  @override
  String years(int years) => '${_numToWordsFormatter(years)} taon';
  @override
  String wordSeparator() => ' ';
}

/// English short relative date time
class TlPhShortRelativeDateTime implements RelativeDateTime {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ngayon';
  @override
  String aboutAMinute(int minutes) => '1m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '~1o';
  @override
  String hours(int hours) => '${hours}o';
  @override
  String aDay(int hours) => '~1a';
  @override
  String days(int days) => '${days}a';
  @override
  String aboutAMonth(int days) => '~1bu';
  @override
  String months(int months) => '${months}bu';
  @override
  String aboutAYear(int year) => '~1t';
  @override
  String years(int years) => '${years}t';
  @override
  String wordSeparator() => ' ';
}

String _numToWordsFormatter(int number) {
  final numToWords = <String>[
    '',
    'isa',
    'dalawa',
    'tatlo',
    'apat',
    'lima',
    'anim',
    'pito',
    'walo',
    'siyam',
    'sampu'
  ];
  const vowels = 'aeiou';

  try {
    final word = numToWords[number];
    final lastLetterOfWord = word[word.length - 1];
    if (vowels.contains(lastLetterOfWord)) {
      return '${word}ng';
    }
    return '$word na';
  } catch (err) {
    return '$number';
  }
}
