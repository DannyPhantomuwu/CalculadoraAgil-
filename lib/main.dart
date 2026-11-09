import 'package:flutter/material.dart';
import 'calculator.dart';

void main() => runApp(const CalculadoraAgilApp());

class CalculadoraAgilApp extends StatelessWidget {
  const CalculadoraAgilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Ágil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String entry = '';
  String result = '0';
  String lastOperation = '';
  String error = '';
  bool resultReady = false;

  void press(String key) {
    setState(() {
      error = '';

      if (key == 'AC') {
        entry = '';
        result = '0';
        lastOperation = '';
        resultReady = false;
      } else if (key == '⌫') {
        if (entry.isNotEmpty) {
          entry = entry.substring(0, entry.length - 1);
        }
      } else if (key == '=') {
        if (entry.isEmpty) return;
        try {
          final computed = Calculator.evaluate(entry);
          lastOperation = '$entry = $computed';
          result = computed;
          entry = '';
          resultReady = true;
        } on FormatException catch (e) {
          error = e.message;
        } catch (_) {
          error = 'Operación inválida';
        }
      } else {
        const digits = '0123456789.';
        const operators = '+−×÷^';
        if (!digits.contains(key) &&
            !operators.contains(key) &&
            key != '(' &&
            key != ')') {
          return;
        }

        if (resultReady && operators.contains(key)) {
          entry = result;
        } else if (resultReady) {
          entry = '';
        }
        resultReady = false;

        if (key == '.') {
          final parts = entry.split(RegExp(r'[+−×÷^()]'));
          if (parts.last.contains('.')) return;
        }
        entry += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['AC', '⌫', '(', ')'],
      ['7', '8', '9', '÷'],
      ['4', '5', '6', '×'],
      ['1', '2', '3', '−'],
      ['0', '.', '^', '+'],
      ['='],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Ágil'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('OPERACIÓN'),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          entry.isEmpty ? '0' : entry,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('RESULTADO'),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          result,
                          style: const TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.isNotEmpty ? error : lastOperation,
                        style: TextStyle(
                          color: error.isNotEmpty
                              ? Colors.orangeAccent
                              : Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...keys.map(
                (row) => Expanded(
                  child: Row(
                    children: row.map((key) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: FilledButton(
                            onPressed: () => press(key),
                            style: FilledButton.styleFrom(
                              backgroundColor: key == '='
                                  ? const Color(0xFF2563EB)
                                  : ['AC', '⌫'].contains(key)
                                      ? const Color(0xFF4B5563)
                                      : const Color(0xFF253044),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              key,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
