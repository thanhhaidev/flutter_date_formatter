import 'package:flutter_date_formatter/src/config/date_formatter_config.dart';
import 'package:flutter_date_formatter/src/locale/locale.dart';
import 'package:flutter_date_formatter/src/models/locale.dart';
import 'package:intl/intl.dart';

/// A utility class that provides helper methods for supported locales.
class SupportedLocalesUtils {
  SupportedLocalesUtils._();

  static final Map<String, DateFormatterLocale> _supportedLocales = {
    'am': AmLocale(),
    'ar': ArLocale(),
    'az': AzLocale(),
    'be': BeLocale(),
    'bn': BnLocale(),
    'bs': BsLocale(),
    'ca': CaLocale(),
    'cs': CsLocale(),
    'da': DaLocale(),
    'de': DeLocale(),
    'el': GrLocale(),
    'en': EnLocale(),
    'es': EsLocale(),
    'et': EtLocale(),
    'fa': FaLocale(),
    'fi': FiLocale(),
    'fr': FrLocale(),
    // Non-standard code for Greek, kept for backward compatibility.
    'gr': GrLocale(),
    'he': HeLocale(),
    'hi': HiLocale(),
    'hr': HrLocale(),
    'hu': HuLocale(),
    'id': IdLocale(),
    'it': ItLocale(),
    'ja': JaLocale(),
    'ka': KaLocale(),
    'km': KmLocale(),
    'ko': KoLocale(),
    'lv': LvLocale(),
    'mn': MnLocale(),
    'ms': MsMyLocale(),
    'ms_MY': MsMyLocale(),
    'my': MyLocale(),
    'nb': NbLocale(),
    'nl': NlLocale(),
    'pl': PlLocale(),
    'ps': PsLocale(),
    'pt': PtLocale(),
    'ro': RoLocale(),
    'ru': RuLocale(),
    'sk': SkLocale(),
    'sr': SrLocale(),
    'sv': SvLocale(),
    'ta': TaLocale(),
    'th': ThLocale(),
    'tl_PH': TlPhLocale(),
    'tr': TrLocale(),
    'uk': UkLocale(),
    'ur': UrLocale(),
    'vi': ViLocale(),
    'zh': ZhLocale(),
    'zh_CN': ZhCnLocale(),
    'zh_HK': ZhTwLocale(),
    'zh_TW': ZhTwLocale(),
  };

  static final Map<String, DateFormatterLocale> _onlySupportedRelatives = {
    'dv': DvLocale(),
    'ku': KuLocale(),
    'nn': NnLocale(),
    'rw': RwLocale(),
    'tk': TkLocale(),
  };

  /// Returns a [DateFormatterLocale] instance for the given locale code.
  ///
  /// The lookup accepts underscore and BCP-47 (hyphenated) tags in any case,
  /// such as `zh_CN`, `zh-cn` or `pt-BR`. A tag that is not registered falls
  /// back to its language code, then to English. When [locale] is `null`,
  /// [DateFormatterConfig.locale], then [Intl.defaultLocale], is used.
  static DateFormatterLocale getLocale(String? locale) {
    return _resolve(locale, relative: false) ?? _supportedLocales['en']!;
  }

  /// Returns a [DateFormatterLocale] instance for the given locale code,
  /// including those that only support relative date formatting.
  ///
  /// See [getLocale] for how the locale code is resolved.
  static DateFormatterLocale getRelativeLocale(String? locale) {
    return _resolve(locale, relative: true) ?? _supportedLocales['en']!;
  }

  /// Returns `true` if the given locale, or its language, is supported.
  static bool isLocaleSupported(String locale) {
    return _resolve(locale, relative: false) != null;
  }

  /// Returns a list of supported locales.
  static List<String> getSupportedLocales() {
    return _supportedLocales.keys.toList();
  }

  /// Returns a list of supported relative locales.
  static List<String> getSupportedRelativeLocales() {
    return {..._supportedLocales.keys, ..._onlySupportedRelatives.keys}
        .toList();
  }

  /// Override and add a new locale to the supported locales.
  ///
  /// The locale is used for both pattern and relative formatting.
  static void registerLocale(
    String locale,
    DateFormatterLocale localeInstance,
  ) {
    _supportedLocales[_canonicalize(locale)] = localeInstance;
  }

  /// Converts a locale tag such as `zh-cn` or `ZH_CN` to the `zh_CN` form
  /// used as keys of the locale maps.
  static String _canonicalize(String locale) {
    final parts = locale.trim().replaceAll('-', '_').split('_');
    return [
      parts.first.toLowerCase(),
      for (final part in parts.skip(1))
        switch (part.length) {
          2 => part.toUpperCase(),
          4 => '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
          _ => part,
        },
    ].join('_');
  }

  static DateFormatterLocale? _resolve(
    String? locale, {
    required bool relative,
  }) {
    final tag = DateFormatterConfig.resolveLocale(locale);
    if (tag == null || tag.trim().isEmpty) {
      return null;
    }

    final canonical = _canonicalize(tag);
    final parts = canonical.split('_');
    final candidates = [
      canonical,
      if (parts.length > 2) '${parts.first}_${parts.last}',
      parts.first,
    ];

    for (final candidate in candidates) {
      final match = _supportedLocales[candidate] ??
          (relative ? _onlySupportedRelatives[candidate] : null);
      if (match != null) {
        return match;
      }
    }
    return null;
  }
}
