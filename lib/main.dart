import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  String _output = "0";
  String _operation = "";
  double _num1 = 0;
  bool _isNew = true;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        _output = "0";
        _num1 = 0;
        _operation = "";
        _isNew = true;
      } else if (buttonText == "C") {
        _output = "0";
        _isNew = true;
      } else if (["+", "-", "×", "÷"].contains(buttonText)) {
        _num1 = double.tryParse(_output) ?? 0;
        _operation = buttonText;
        _isNew = true;
      } else if (buttonText == "=") {
        double num2 = double.tryParse(_output) ?? 0;
        switch (_operation) {
          case "+":
            _output = (_num1 + num2).toString();
            break;
          case "-":
            _output = (_num1 - num2).toString();
            break;
          case "×":
            _output = (_num1 * num2).toString();
            break;
          case "÷":
            _output = num2 == 0 ? "Error" : (_num1 / num2).toString();
            break;
        }
        _isNew = true;
      } else {
        if (_isNew) {
          _output = buttonText;
          _isNew = false;
        } else {
          if (buttonText == "." && _output.contains(".")) return;
          _output += buttonText;
        }
      }
    });
  }

  Widget _buildButton(String text, {Color? color, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFFFFAFAF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => _buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 247, 247),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pinkAccent, width: 4), // Pink border outline
            borderRadius: BorderRadius.circular(16), // Optional rounded corners for the whole calculator
          ),
          padding: const EdgeInsets.all(8), // Padding around the calculator body
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Text(
                  _output,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 32, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 300,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD0D0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildButton("AC", color: Colors.pinkAccent, flex: 2),
                        _buildButton("C", color: Colors.pinkAccent),
                        _buildButton("÷", color: Colors.pinkAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("7"),
                        _buildButton("8"),
                        _buildButton("9"),
                        _buildButton("×", color: Colors.pinkAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("4"),
                        _buildButton("5"),
                        _buildButton("6"),
                        _buildButton("-", color: Colors.pinkAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("1"),
                        _buildButton("2"),
                        _buildButton("3"),
                        _buildButton("+", color: Colors.pinkAccent),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("0", flex: 2),
                        _buildButton("."),
                        _buildButton("=", color: Colors.pinkAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
