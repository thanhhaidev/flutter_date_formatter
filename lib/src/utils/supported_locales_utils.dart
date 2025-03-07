import 'package:flutter_date_formatter/src/locale/locale.dart';
import 'package:flutter_date_formatter/src/models/locale.dart';
import 'package:intl/intl.dart';

/// A utility class that provides helper methods for supported locales.
class SupportedLocalesUtils {
  SupportedLocalesUtils._();

  static final Map<String, Locale> _supportedLocales = {
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
    'en': EnLocale(),
    'es': EsLocale(),
    'et': EtLocale(),
    'fa': FaLocale(),
    'fi': FiLocale(),
    'fr': FrLocale(),
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
    'mn_MY': MsMyLocale(),
    'ms_MY': MsMyLocale(),
    'my': MyLocale(),
    'nb': NbLocale(),
    'nl': NlLocale(),
    'pl': PlLocale(),
    'ps': PsLocale(),
    'pt': PtLocale(),
    'ro': RoLocale(),
    'ru': RuLocale(),
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
  };

  static final Map<String, Locale> _onlySupportedRelatives = {
    'dv': DvLocale(),
    'gr': GrLocale(),
    'ku': KuLocale(),
    'nn': NnLocale(),
    'rw': RwLocale(),
    'tk': TkLocale(),
  };

  static final Map<String, Locale> _mergedSupportedLocales = {
    ..._supportedLocales,
    ..._onlySupportedRelatives,
  };

  /// Returns a [Locale] instance for the given locale code.
  static Locale getLocale(String? locale) {
    final defaultLocale = locale ?? Intl.defaultLocale;

    final defaultLocaleSupport = _supportedLocales['en']!;
    if (defaultLocale != null && defaultLocale.isNotEmpty) {
      final finalLocale = defaultLocale.split('_').first;
      return _supportedLocales[locale] ??
          _supportedLocales[finalLocale] ??
          defaultLocaleSupport;
    }
    return defaultLocaleSupport;
  }

  /// Returns a [Locale] instance for the given locale code, including those
  /// that only support relative date formatting.
  static Locale getRelativeLocale(String? locale) {
    final defaultLocale = locale ?? Intl.defaultLocale;

    final defaultLocaleSupport = _supportedLocales['en']!;
    if (defaultLocale != null && defaultLocale.isNotEmpty) {
      final finalLocale = defaultLocale.split('_').first;
      return _mergedSupportedLocales[locale] ??
          _mergedSupportedLocales[finalLocale] ??
          defaultLocaleSupport;
    }
    return defaultLocaleSupport;
  }

  /// Returns `true` if the given locale is supported.
  static bool isLocaleSupported(String locale) {
    return _supportedLocales.containsKey(locale.toLowerCase());
  }

  /// Returns a list of supported locales.
  static List<String> getSupportedLocales() {
    return _supportedLocales.keys.toList();
  }

  /// Returns a list of supported relative locales.
  static List<String> getSupportedRelativeLocales() {
    return _mergedSupportedLocales.keys.toList();
  }

  /// Override and add a new locale to the supported locales.
  static void registerLocale(String locale, Locale localeInstance) {
    _supportedLocales[locale] = localeInstance;
  }
}
