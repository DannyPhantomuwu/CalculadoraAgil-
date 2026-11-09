import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_agil/calculator.dart';

void main() {
  test('suma', () => expect(Calculator.evaluate('2+3'), '5'));
  test('resta', () => expect(Calculator.evaluate('7-4'), '3'));
  test('multiplicación', () => expect(Calculator.evaluate('6*3'), '18'));
  test('división', () => expect(Calculator.evaluate('8/2'), '4'));
  test('precedencia', () => expect(Calculator.evaluate('2+3*4'), '14'));
  test('paréntesis', () => expect(Calculator.evaluate('(2+3)*4'), '20'));
  test('negativos', () => expect(Calculator.evaluate('-2+5'), '3'));
  test('potencias', () => expect(Calculator.evaluate('2^3'), '8'));
  test('decimales', () => expect(Calculator.evaluate('0.1+0.2'), '0.3'));
  test('redondeo', () => expect(Calculator.evaluate('1/3'), '0.33333'));
  test('división entre cero', () =>
      expect(() => Calculator.evaluate('5/0'), throwsFormatException));
  test('operación incompleta', () =>
      expect(() => Calculator.evaluate('2+*3'), throwsFormatException));
  test('carácter no válido', () =>
      expect(() => Calculator.evaluate('2a'), throwsFormatException));
}
