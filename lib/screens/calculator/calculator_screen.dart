import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onHistoryTap;

  const CalculatorScreen({
    super.key,
    this.onBackTap,
    this.onHistoryTap,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double? _firstOperand;
  String? _operator;
  bool _shouldResetDisplay = false;

  void _onDigitPress(String digit) {
    setState(() {
      if (_display == '0' || _shouldResetDisplay) {
        _display = digit;
        _shouldResetDisplay = false;
      } else {
        if (_display.length < 12) {
          _display += digit;
        }
      }
    });
  }

  void _onDecimalPress() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _onClear() {
    setState(() {
      _display = '0';
      _firstOperand = null;
      _operator = null;
      _shouldResetDisplay = false;
    });
  }

  void _onBackspace() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = '0';
      }
    });
  }

  void _onPercent() {
    setState(() {
      final val = double.tryParse(_display) ?? 0;
      _display = (val / 100).toString();
      if (_display.endsWith('.0')) {
        _display = _display.substring(0, _display.length - 2);
      }
    });
  }

  void _onOperatorPress(String op) {
    setState(() {
      _firstOperand = double.tryParse(_display);
      _operator = op;
      _shouldResetDisplay = true;
    });
  }

  void _onEqualPress() {
    if (_firstOperand == null || _operator == null) return;
    final secondOperand = double.tryParse(_display) ?? 0;
    double result = 0;

    switch (_operator) {
      case '+':
        result = _firstOperand! + secondOperand;
        break;
      case '-':
        result = _firstOperand! - secondOperand;
        break;
      case '×':
        result = _firstOperand! * secondOperand;
        break;
      case '÷':
        if (secondOperand != 0) {
          result = _firstOperand! / secondOperand;
        } else {
          setState(() {
            _display = 'Error';
            _shouldResetDisplay = true;
          });
          return;
        }
        break;
    }

    setState(() {
      if (result % 1 == 0) {
        _display = result.toInt().toString();
      } else {
        _display = result.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      _firstOperand = null;
      _operator = null;
      _shouldResetDisplay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF1E1E1E);
    const Color btnGrey = Color(0xFFA5A5A5);
    const Color btnDark = Color(0xFF3C3C3C);
    const Color btnOrange = Color(0xFFFF9500);

    return Scaffold(
      backgroundColor: bgDark,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 402),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    // Top Navigation Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color(0xFFF5F5F5),
                            size: 20,
                          ),
                          onPressed: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.history_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: widget.onHistoryTap ??
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Calculation history is empty')),
                                );
                              },
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Number Display
                    Padding(
                      padding: const EdgeInsets.only(right: 18, bottom: 20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _display,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 64,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Keypad Row 1: AC, %, Backspace, ÷
                    _buildButtonRow([
                      _KeySpec(label: 'AC', color: btnGrey, textColor: const Color(0xFF1C1C1E), onTap: _onClear),
                      _KeySpec(label: '%', color: btnGrey, textColor: Colors.black, onTap: _onPercent),
                      _KeySpec(
                        icon: Icons.backspace_outlined,
                        color: btnGrey,
                        textColor: Colors.black,
                        onTap: _onBackspace,
                      ),
                      _KeySpec(label: '÷', color: btnOrange, textColor: Colors.white, onTap: () => _onOperatorPress('÷')),
                    ]),

                    const SizedBox(height: 12),

                    // Keypad Row 2: 7, 8, 9, ×
                    _buildButtonRow([
                      _KeySpec(label: '7', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('7')),
                      _KeySpec(label: '8', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('8')),
                      _KeySpec(label: '9', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('9')),
                      _KeySpec(label: '×', color: btnOrange, textColor: Colors.white, onTap: () => _onOperatorPress('×')),
                    ]),

                    const SizedBox(height: 12),

                    // Keypad Row 3: 4, 5, 6, -
                    _buildButtonRow([
                      _KeySpec(label: '4', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('4')),
                      _KeySpec(label: '5', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('5')),
                      _KeySpec(label: '6', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('6')),
                      _KeySpec(label: '-', color: btnOrange, textColor: Colors.white, onTap: () => _onOperatorPress('-')),
                    ]),

                    const SizedBox(height: 12),

                    // Keypad Row 4: 1, 2, 3, +
                    _buildButtonRow([
                      _KeySpec(label: '1', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('1')),
                      _KeySpec(label: '2', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('2')),
                      _KeySpec(label: '3', color: btnDark, textColor: Colors.white, onTap: () => _onDigitPress('3')),
                      _KeySpec(label: '+', color: btnOrange, textColor: Colors.white, onTap: () => _onOperatorPress('+')),
                    ]),

                    const SizedBox(height: 12),

                    // Keypad Row 5: 0 (wide), ., =
                    Row(
                      children: [
                        // Wide '0' Button
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () => _onDigitPress('0'),
                            borderRadius: BorderRadius.circular(36),
                            child: Container(
                              height: 72,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.only(left: 28),
                              decoration: BoxDecoration(
                                color: btnDark,
                                borderRadius: BorderRadius.circular(36),
                              ),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                '0',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Dot '.' Button
                        Expanded(
                          child: _buildSingleButton(
                            _KeySpec(label: '.', color: btnDark, textColor: Colors.white, onTap: _onDecimalPress),
                          ),
                        ),
                        // Equal '=' Button
                        Expanded(
                          child: _buildSingleButton(
                            _KeySpec(label: '=', color: btnOrange, textColor: Colors.white, onTap: _onEqualPress),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<_KeySpec> keys) {
    return Row(
      children: keys.map((key) => Expanded(child: _buildSingleButton(key))).toList(),
    );
  }

  Widget _buildSingleButton(_KeySpec spec) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        margin: const EdgeInsets.all(4),
        child: InkWell(
          onTap: spec.onTap,
          customBorder: const CircleBorder(),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: spec.color,
            ),
            alignment: Alignment.center,
            child: spec.icon != null
                ? Icon(
                    spec.icon,
                    color: spec.textColor,
                    size: 28,
                  )
                : Text(
                    spec.label ?? '',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: spec.textColor,
                      fontSize: spec.label == 'AC' ? 24 : 32,
                      fontWeight: spec.color == const Color(0xFFA5A5A5) ? FontWeight.w400 : FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _KeySpec {
  final String? label;
  final IconData? icon;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  _KeySpec({
    this.label,
    this.icon,
    required this.color,
    required this.textColor,
    required this.onTap,
  });
}
