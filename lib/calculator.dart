import 'dart:math' as math;

class Calculator {
  static String evaluate(String expression) {
    if (expression.trim().isEmpty) {
      throw const FormatException('Operación vacía');
    }
    final parser = _Parser(expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('−', '-'));
    final value = parser.parse();
    if (!value.isFinite) throw const FormatException('Resultado no válido');

    final rounded = double.parse(value.toStringAsFixed(5));
    if (rounded == 0) return '0';
    if (rounded == rounded.truncateToDouble() && rounded.abs() < 1e15) {
      return rounded.toInt().toString();
    }
    return rounded.toString();
  }
}

class _Parser {
  _Parser(this.input);
  final String input;
  int i = 0;

  double parse() {
    final result = _sum();
    _skip();
    if (i != input.length) throw const FormatException('Carácter no permitido');
    return result;
  }

  double _sum() {
    var result = _product();
    while (true) {
      _skip();
      if (_eat('+')) {
        result += _product();
      } else if (_eat('-')) {
        result -= _product();
      } else {
        return result;
      }
    }
  }

  double _product() {
    var result = _unary();
    while (true) {
      _skip();
      if (_eat('*')) {
        result *= _unary();
      } else if (_eat('/')) {
        final divisor = _unary();
        if (divisor == 0) {
          throw const FormatException('No se puede dividir entre cero');
        }
        result /= divisor;
      } else {
        return result;
      }
    }
  }

  double _unary() {
    _skip();
    if (_eat('+')) return _unary();
    if (_eat('-')) return -_unary();
    return _power();
  }

  double _power() {
    var result = _primary();
    _skip();
    if (_eat('^')) {
      result = math.pow(result, _unary()).toDouble();
    }
    return result;
  }

  double _primary() {
    _skip();
    if (_eat('(')) {
      final result = _sum();
      _skip();
      if (!_eat(')')) throw const FormatException('Falta cerrar paréntesis');
      return result;
    }
    final start = i;
    var dots = 0;
    while (i < input.length && _isNumberCharacter(input[i])) {
      if (input[i] == '.') dots++;
      i++;
    }
    if (start == i || dots > 1) throw const FormatException('Número inválido');
    final value = double.tryParse(input.substring(start, i));
    if (value == null) throw const FormatException('Número inválido');
    return value;
  }

  bool _isNumberCharacter(String c) =>
      (c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57) || c == '.';

  bool _eat(String char) {
    if (i < input.length && input[i] == char) {
      i++;
      return true;
    }
    return false;
  }

  void _skip() {
    while (i < input.length && input[i].trim().isEmpty) {
      i++;
    }
  }
}
