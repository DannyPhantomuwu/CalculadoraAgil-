import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_agil/main.dart';

void main() {
  testWidgets('Muestra los elementos de la calculadora', (tester) async {
    await tester.binding.setSurfaceSize(const Size(600, 1200));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const CalculadoraAgilApp());
    await tester.pumpAndSettle();

    expect(find.text('Calculadora Ágil'), findsOneWidget);
    expect(find.text('OPERACIÓN'), findsOneWidget);
    expect(find.text('RESULTADO'), findsOneWidget);
    expect(find.text('AC'), findsOneWidget);
  });

  testWidgets('Realiza una suma correctamente', (tester) async {
    await tester.binding.setSurfaceSize(const Size(600, 1200));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const CalculadoraAgilApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('5'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pumpAndSettle();

    expect(find.text('5+3 = 8'), findsOneWidget);
  });
}
