import 'package:flutter/material.dart';
import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();

  runApp(const MyApp());
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Formatted Date (en):',
            ),
            Text(
              FlutterDateFormatter('do MMMM yyyy', 'en').format(DateTime.now()),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            const Text(
              'Formatted Relative Date:',
            ),
            Text(
              FlutterDateFormatter.formatRelativeDateTime(
                DateTime.now().subtract(Duration(days: 5)),
                locale: 'en',
              ),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            const Text(
              'Formatted Date (vi):',
            ),
            Text(
              FlutterDateFormatter('do MMMM yyyy', 'vi').format(DateTime.now()),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            const Text(
              'Formatted Relative Date:',
            ),
            Text(
              FlutterDateFormatter.formatRelativeDateTime(
                DateTime.now().subtract(Duration(days: 5)),
                locale: 'vi',
              ),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            const Text(
              'Formatted Date (es):',
            ),
            Text(
              FlutterDateFormatter('do MMMM yyyy', 'es').format(DateTime.now()),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            const Text(
              'Formatted Relative Date:',
            ),
            Text(
              FlutterDateFormatter.formatRelativeDateTime(
                DateTime.now().subtract(Duration(days: 5)),
                locale: 'es',
              ),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
