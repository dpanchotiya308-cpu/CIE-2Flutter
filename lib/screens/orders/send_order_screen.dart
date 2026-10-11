import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_header.dart';

class SendOrderScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSend;

  const SendOrderScreen({
    super.key,
    this.onBackTap,
    this.onSend,
  });

  @override
  State<SendOrderScreen> createState() => _SendOrderScreenState();
}

class _SendOrderScreenState extends State<SendOrderScreen> {
  String _selectedMaterial = 'EN-D';
  final TextEditingController _widthController = TextEditingController(text: '20');
  String _selectedDiagram = 'Round';
  final TextEditingController _lengthController = TextEditingController(text: '45.32');
  String _selectedUnit = 'mm';
  final TextEditingController _pieceController = TextEditingController(text: '20');

  final List<String> _materials = ['EN-D', 'EN-8', 'EN-19', 'Mild Steel', 'SS 304'];
  final List<String> _diagrams = ['Round', 'Square', 'Hexagon', 'Flat'];
  final List<String> _units = ['mm', 'cm', 'inch'];

  @override
  void dispose() {
    _widthController.dispose();
    _lengthController.dispose();
    _pieceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Send order',
        onBack: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 402),
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),

                        // Row 1: Material (Dropdown)
                        _buildRow(
                          label: 'Material',
                          child: _buildDropdownPill(
                            value: _selectedMaterial,
                            items: _materials,
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedMaterial = val);
                            },
                          ),
                        ),

                        const SizedBox(height: 38),

                        // Row 2: Width (Text field)
                        _buildRow(
                          label: 'Width',
                          child: _buildTextPill(
                            controller: _widthController,
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        const SizedBox(height: 38),

                        // Row 3: Diagram (Dropdown)
                        _buildRow(
                          label: 'Diagram',
                          child: _buildDropdownPill(
                            value: _selectedDiagram,
                            items: _diagrams,
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedDiagram = val);
                            },
                          ),
                        ),

                        const SizedBox(height: 38),

                        // Row 4: Length (Pill + Unit dropdown)
                        _buildRow(
                          label: 'Length',
                          child: Row(
                            children: [
                              // Length value pill
                              Expanded(
                                flex: 5,
                                child: _buildTextPill(
                                  controller: _lengthController,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Unit dropdown pill
                              Expanded(
                                flex: 5,
                                child: _buildDropdownPill(
                                  value: _selectedUnit,
                                  items: _units,
                                  onChanged: (val) {
                                    if (val != null) setState(() => _selectedUnit = val);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 38),

                        // Row 5: Piece (Text field)
                        _buildRow(
                          label: 'Piece',
                          child: _buildTextPill(
                            controller: _pieceController,
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        const SizedBox(height: 60),

                        // Send Button (Figma: width 225px, height 67px, radius 62px)
                        GestureDetector(
                          onTap: () {
                            if (widget.onSend != null) {
                              widget.onSend!();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Order sent successfully!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 225,
                            height: 62,
                            decoration: BoxDecoration(
                              color: AppColors.primaryYellow,
                              borderRadius: BorderRadius.circular(62),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Send',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: AppColors.textBlack,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRow({required String label, required Widget child}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label (Inter 700, 20px, #FFFFFF)
        SizedBox(
          width: 105,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: AppColors.textWhite,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Input pill container
        Expanded(child: child),
      ],
    );
  }

  Widget _buildTextPill({
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(62),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Inter',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdownPill({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(62),
      ),
      alignment: Alignment.center,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF1E1B13),
            size: 24,
          ),
          isExpanded: true,
          alignment: Alignment.center,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          dropdownColor: const Color(0xFFE2E8F0),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Center(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
