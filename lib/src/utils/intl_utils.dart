import 'dart:async';

import 'package:flutter_date_formatter/src/config/date_formatter_config.dart';
import 'package:flutter_date_formatter/src/models/locale.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// Internal helpers for working with `intl` date data.
class IntlUtils {
  IntlUtils._();

  static bool _isInitialized = false;

  /// Loads the bundled `intl` date symbols once, so that formatting works
  /// without calling `initializeDateFormatting()` first.
  static void ensureInitialized() {
    if (_isInitialized) return;
    _isInitialized = true;
    // The local data source initializes synchronously.
    unawaited(initializeDateFormatting());
  }

  /// Returns the requested [locale] (or the configured default) when `intl`
  /// has date data for it, keeping its region (`en_GB`, `pt_BR`), or `null`.
  static String? verifiedLocale(String? locale) {
    final tag = DateFormatterConfig.resolveLocale(locale);
    if (tag == null || tag.trim().isEmpty) return null;
    return _verify(tag.trim());
  }

  /// Returns an `intl` locale for [locale]: the requested one when `intl`
  /// supports it, otherwise the code of [fallback], otherwise `en`.
  static String resolveLocale(String? locale, DateFormatterLocale fallback) {
    return verifiedLocale(locale) ?? _verify(fallback.code()) ?? 'en';
  }

  static String? _verify(String tag) => Intl.verifiedLocale(
        tag,
        dateTimeSymbolMap().containsKey,
        onFailure: (_) => null,
      );
}
