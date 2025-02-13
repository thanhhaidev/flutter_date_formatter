import 'package:flutter_date_formatter/src/locale/locale.dart';
import 'package:flutter_date_formatter/src/models/locale.dart';

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
    'dv': DvLocale(),
    'en': EnLocale(),
    'es': EsLocale(),
    'et': EtLocale(),
    'fa': FaLocale(),
    'fi': FiLocale(),
    'fr': FrLocale(),
    'gr': GrLocale(),
    'he': HeLocale(),
    'hi': HiLocale(),
    'hr': HrLocale(),
    'hu': HuLocale(),
    'id': IdLocale(),
    'it': ItLocale(),
    'ja': JaLocale(),
    'km': KmLocale(),
    'ko': KoLocale(),
    'ku': KuLocale(),
    'lv': LvLocale(),
    'mn': MnLocale(),
    'mn_MY': MsMyLocale(),
    'ms_MY': MsMyLocale(),
    'my': MyLocale(),
    'nb': NbLocale(),
    'nl': NlLocale(),
    'nn': NnLocale(),
    'pl': PlLocale(),
    'pt': PtLocale(),
    'ro': RoLocale(),
    'ru': RuLocale(),
    'rw': RwLocale(),
    'sr': SrLocale(),
    'sv': SvLocale(),
    'ta': TaLocale(),
    'th': ThLocale(),
    'tk': TkLocale(),
    'tr': TrLocale(),
    'uk': UkLocale(),
    'ur': UrLocale(),
    'vi': ViLocale(),
    'zh': ZhLocale(),
    'zh_CN': ZhCnLocale(),
  };

  /// Returns a [Locale] instance for the given locale code.
  static Locale getLocale(String locale) {
    return _supportedLocales[locale.toLowerCase()] ?? _supportedLocales['en']!;
  }

  /// Returns `true` if the given locale is supported.
  static bool isLocaleSupported(String locale) {
    return _supportedLocales.containsKey(locale.toLowerCase());
  }

  /// Returns a list of supported locales.
  static List<String> getSupportedLocales() {
    return _supportedLocales.keys.toList();
  }
}
