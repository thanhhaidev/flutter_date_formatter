import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_formatter/flutter_date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
    SupportedLocalesUtils.registerLocale('vi', ViLocaleCustom());
  });

  testWidgets('renders the example app', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter Date Formatter Example'), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);
  });
}
