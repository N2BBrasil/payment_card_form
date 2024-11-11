import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:payment_card_form/payment_card_form.dart';
import 'package:payment_card_form/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  final faker = Faker();

  Future<void> pumpForm(WidgetTester tester, PaymentCardForm form) async {
    await tester.pumpWidget(
      Material(
        child: MaterialApp(
          home: Scaffold(
            body: form,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
  }

  group('validate', () {
    testWidgets(
      'should return null when form is invalid',
      (tester) async {
        final key = GlobalKey<PaymentCardFormState>();

        await pumpForm(
          tester,
          PaymentCardForm(key: key),
        );

        expect(key.currentState!.validate(), isNull);
      },
    );

    testWidgets(
      'should return PaymentCard when form is valid',
      (tester) async {
        final key = GlobalKey<PaymentCardFormState>();

        await pumpForm(
          tester,
          PaymentCardForm(key: key),
        );

        await tester.enterText(
          find.byType(CardNumberField),
          '374245455400126',
        );

        await tester.enterText(
          find.byType(HolderNameField),
          faker.person.name(),
        );


        await tester.enterText(
          find.byType(ExpirationDateField),
          DateFormat('MM/yy').format(
            faker.date.dateTime(
              minYear: DateTime.now().add(const Duration(days: 365)).year,
              maxYear: 2099,
            ),
          ),
        );

        expect(key.currentState!.validate(), isA<PaymentCard>());
      },
    );
  });

  group('when allowCVVInsert is true', () {
    testWidgets(
      'should render CVV field',
      (tester) async {
        await pumpForm(
          tester,
          const PaymentCardForm(allowCVVInsert: true),
        );

        expect(find.byType(CVVField), findsOneWidget);
      },
    );

    testWidgets('should add cvv control to form', (tester) async {
      await pumpForm(
        tester,
        const PaymentCardForm(allowCVVInsert: true),
      );

      final form = tester.widget<ReactiveForm>(find.byType(ReactiveForm));

      expect(form.formGroup.control(PaymentCardForm.cvvKey), isNotNull);
    });

    testWidgets(
      'should catch cvv value on form',
      (tester) async {
        await pumpForm(
          tester,
          const PaymentCardForm(allowCVVInsert: true),
        );

        final form = tester.widget<ReactiveForm>(find.byType(ReactiveForm));

        await tester.enterText(
          find.byType(CVVField),
          '123',
        );

        expect(
          form.formGroup.value,
          containsPair(PaymentCardForm.cvvKey, '123'),
        );
      },
    );
  });

  group('when allowCVVInsert is false', () {
    testWidgets(
      'should not render CVV field',
      (tester) async {
        await pumpForm(
          tester,
          const PaymentCardForm(allowCVVInsert: false),
        );

        expect(find.byType(CVVField), findsNothing);
      },
    );

    testWidgets('should not add cvv control to form', (tester) async {
      await pumpForm(
        tester,
        const PaymentCardForm(allowCVVInsert: false),
      );

      final form = tester.widget<ReactiveForm>(find.byType(ReactiveForm));

      expect(
        () => form.formGroup.control(PaymentCardForm.cvvKey),
        throwsA(isA<FormControlNotFoundException>()),
      );
    });

    testWidgets(
      'should not catch cvv value on form',
      (tester) async {
        await pumpForm(
          tester,
          const PaymentCardForm(allowCVVInsert: false),
        );

        final form = tester.widget<ReactiveForm>(find.byType(ReactiveForm));

        expect(
          form.formGroup.value,
          isNot(contains(PaymentCardForm.cvvKey)),
        );
      },
    );
  });
}
