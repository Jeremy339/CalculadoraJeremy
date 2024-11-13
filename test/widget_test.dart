import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora_jeremy/main.dart';

void main() {
  testWidgets('Renderizar Calculadora', (WidgetTester tester) async {
    // Construir el widget de MyApp y activarlo
    await tester.pumpWidget(MyApp());

    // Verificar si el texto inicial es '0'
    expect(find.text('0'), findsOneWidget);

    // Verificar si algunos botones como el de "AC" están presentes
    expect(find.text('AC'), findsOneWidget);
  });

  testWidgets('Verificar operación de suma', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Simular entrada de números y operaciones
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();

    // Comprobar el resultado de la operación
    expect(find.text('3'), findsOneWidget);
  });
}
