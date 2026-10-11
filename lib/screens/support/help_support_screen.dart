import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class FaqItem {
  final String question;
  final String answer;
  bool isExpanded;

  FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}

class HelpSupportScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onContactSupport;
  final ValueChanged<int>? onNavTap;

  const HelpSupportScreen({
    super.key,
    this.onBackTap,
    this.onMenuTap,
    this.onContactSupport,
    this.onNavTap,
  });

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int _currentNavIndex = 0; // 'Home' tab is active in screenshot
  final TextEditingController _searchController = TextEditingController();

  late List<FaqItem> _faqs;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _faqs = [
      FaqItem(
        question: 'How do I log scrap materials?',
        answer:
            'Go to Menu > Log Material Yield, enter your offcut and scrap weights in kg, and submit the ledger record.',
        isExpanded: false,
      ),
      FaqItem(
        question: 'How is the machining fee calculated?',
        answer:
            'Fees are auto-calculated based on per-piece cutting dimensions and pre-agreed labor rates with your supplier.',
        isExpanded: true, // Expanded by default matching Figma
      ),
      FaqItem(
        question: 'Why is my PoD rejected?',
        answer:
            'PoD may be rejected if the receipt stamp is unclear, signature is missing, or weight counts do not reconcile with dispatch.',
        isExpanded: false,
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FaqItem> get _filteredFaqs {
    if (_searchQuery.isEmpty) return _faqs;
    return _faqs
        .where((faq) =>
            faq.question.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            faq.answer.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Help & Support',
        onBack: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Color(0xFFF5B800),
              size: 34,
            ),
            onPressed: widget.onMenuTap ??
                () {
                  Navigator.pushNamed(context, '/business-menu');
                },
          ),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: AppFooter(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          widget.onNavTap?.call(index);
        },
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Search Input Box
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF222B3F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val;
                            });
                          },
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: 'Search FAQs or articles...',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF94A3B8),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section Title
                      const Text(
                        'Frequently Asked Questions',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Accordion Items
                      ..._filteredFaqs.map((faq) => _buildFaqTile(faq)),

                      const SizedBox(height: 48),

                      // Action Button: Contact SubSetu Support
                      Center(
                        child: GestureDetector(
                          onTap: widget.onContactSupport ??
                              () {
                                Navigator.pushNamed(context, '/contact-us');
                              },
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(maxWidth: 320),
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF59E0B)
                                      .withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Contact SubSetu Support',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFaqTile(FaqItem faq) {
    final bool isExpanded = faq.isExpanded;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF222B3F),
        borderRadius: BorderRadius.circular(14),
        border: isExpanded
            ? Border.all(
                color: const Color(0xFF334155),
                width: 1.5,
              )
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          setState(() {
            faq.isExpanded = !faq.isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      faq.question,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: isExpanded
                            ? const Color(0xFF1D9BF0)
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isExpanded ? '-' : '+',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: isExpanded
                          ? const Color(0xFF1D9BF0)
                          : const Color(0xFF94A3B8),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
                Text(
                  faq.answer,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFF94A3B8),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
