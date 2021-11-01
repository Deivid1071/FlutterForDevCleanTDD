import 'package:flutter/material.dart';
import 'package:flutter_for_dev_dm/ui/page/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets(
    'Should load with correct initial state',
    (WidgetTester tester) async {
      final loginPage = MaterialApp(
        home: LoginPage(),
      );
      await tester.pumpWidget(loginPage);

      final emailTextChildren = find.descendant(
          of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
      expect(emailTextChildren, findsOneWidget,
          reason:
              'Quando o TextFormField tiver apenas um filho, quer dizer que não há erros, pois o prorio label é um filho');

      final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(button.onPressed, null);
    },
  );
}
