import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_dev_dm/ui/page/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([LoginPresenter])
main() {
  late LoginPresenter presenter;
  late StreamController<String> emailErrorController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockLoginPresenter();
    emailErrorController = StreamController<String>();
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    final loginPage = MaterialApp(
      home: LoginPage(
        presenter: presenter,
      ),
    );
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
  });

  testWidgets(
    'Should load with correct initial state',
    (WidgetTester tester) async {
      await loadPage(tester);

      final emailTextChildren = find.descendant(
          of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
      expect(emailTextChildren, findsOneWidget,
          reason:
              'Quando o TextFormField tiver apenas um filho, quer dizer que não há erros, pois o prorio label é um filho');

      final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(button.onPressed, null);
    },
  );

  testWidgets(
    'Should call validate with correct values',
    (WidgetTester tester) async {
      await loadPage(tester);

      final email = faker.internet.email();
      await tester.enterText(find.bySemanticsLabel('Email'), email);
      verify(presenter.validateEmail(email));

      final senha = faker.internet.password();
      await tester.enterText(find.bySemanticsLabel('Senha'), senha);
      verify(presenter.validatePassword(senha));
    },
  );

  testWidgets(
    'Should present error if email is invalid',
    (WidgetTester tester) async {
      await loadPage(tester);

      emailErrorController.add('any_error');
      await tester.pump();

      expect(find.text('any_error'), findsOneWidget);
    },
  );

  testWidgets(
    'Should present no error if email is invalid',
    (WidgetTester tester) async {
      await loadPage(tester);

      emailErrorController.add('');
      await tester.pump();

      expect(
          find.descendant(
              of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
          findsOneWidget,
          reason:
              'Quando o TextFormField tiver apenas um filho, quer dizer que não há erros, pois o prorio label é um filho');
    },
  );
}
