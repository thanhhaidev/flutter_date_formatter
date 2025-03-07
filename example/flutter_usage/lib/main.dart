import 'package:flutter/material.dart' hide Locale;
import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();

  SupportedLocalesUtils.registerLocale('vi', ViLocaleCustom());

  runApp(const MyApp());
}

class ViLocaleCustom extends Locale {
  @override
  String code() => 'vi';

  @override
  String ordinal(int n) => '';

  @override
  String ordinalNumber(int n) => 'ngày thứ $n';

  @override
  RelativeDateTime relativeDateTime() => ViRelativeTime();

  @override
  RelativeDateTime shortRelativeDateTime() => ViShortRelativeTime();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Date Formatter Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Date Formatter Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  DateTime currentDateTime = DateTime.now();
  late TabController _tabController;

  // List of supported locales
  final List<String> supportedLocales =
      SupportedLocalesUtils.getSupportedLocales();

  final List<String> supportedRelativeLocales =
      SupportedLocalesUtils.getSupportedRelativeLocales()..sort();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: supportedRelativeLocales.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: supportedRelativeLocales.map((locale) {
            return Tab(text: locale);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: supportedRelativeLocales.map((locale) {
          return _buildLocaleContent(locale);
        }).toList(),
      ),
    );
  }

  // Helper widget to display formatted date
  Widget _buildFormattedDateSection(String label, String formattedDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              formattedDate,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the content for each locale tab
  Widget _buildLocaleContent(String locale) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Formatting section
            if (!supportedLocales.contains(locale))
              Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Locale $locale is not supported for formatting. Defaulting to English.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.deepPurple),
                ),
              ),
            _buildFormattedDateSection(
                'Formatted Date:',
                currentDateTime.format(
                    pattern: 'do MMMM yyyy', locale: locale)),
            _buildFormattedDateSection('Relative Time (from now):',
                currentDateTime.formatFromNow(locale: locale)),
            _buildFormattedDateSection('Relative Time (to now):',
                currentDateTime.formatToNow(locale: locale)),
            _buildFormattedDateSection(
                'Relative Time (from past):',
                currentDateTime.formatFrom(
                    clock: DateTime.now().subDays(1), locale: locale)),
            _buildFormattedDateSection(
                'Relative Time (to past):',
                currentDateTime.formatTo(
                    clock: DateTime.now().subDays(1), locale: locale)),
            _buildFormattedDateSection(
              'Relative Time Short (from past):',
              currentDateTime.formatFrom(
                clock: DateTime.now().subDays(1),
                locale: locale,
                short: true,
              ),
            ),
            _buildFormattedDateSection(
              'Relative Time Short (to past):',
              currentDateTime.formatTo(
                clock: DateTime.now().subDays(1),
                locale: locale,
                short: true,
              ),
            ),
            _buildFormattedDateSection(
              'Ordinal Number:',
              currentDateTime.formatOrdinalNumber(locale: locale),
            ),
          ],
        ),
      ),
    );
  }
}
