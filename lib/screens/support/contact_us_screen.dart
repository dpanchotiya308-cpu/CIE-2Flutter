import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class ContactUsScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onCallHelpdesk;
  final VoidCallback? onEmailSupport;
  final VoidCallback? onSendMessage;
  final ValueChanged<int>? onNavTap;

  const ContactUsScreen({
    super.key,
    this.onBackTap,
    this.onMenuTap,
    this.onCallHelpdesk,
    this.onEmailSupport,
    this.onSendMessage,
    this.onNavTap,
  });

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  int _currentNavIndex = 0; // 'Home' tab is active in screenshot
  String _selectedCategory = 'Proof of Delivery (PoD) Verification';
  final TextEditingController _messageController = TextEditingController();

  final List<String> _categories = [
    'Proof of Delivery (PoD) Verification',
    'Material Yield Discrepancy',
    'Machining Job Delay',
    'Payment & Settlement Issue',
    'Other Query',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Message sent! Our support team will get back to you shortly.',
        ),
        backgroundColor: Color(0xFFF59E0B),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );

    widget.onSendMessage?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Contact Us',
        onBack: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Color(0xFFF5B800),
              size: 34,
            ),
            onPressed:
                widget.onMenuTap ??
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
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Subtitle
                      const Center(
                        child: Text(
                          'Need help with a Work Order or PoD?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Card 1: Call Helpdesk
                      _buildContactMethodCard(
                        icon: Icons.phone_outlined,
                        iconColor: const Color(0xFF1D9BF0),
                        badgeBgColor: const Color(
                          0xFF1D9BF0,
                        ).withValues(alpha: 0.1),
                        badgeBorderColor: const Color(0xFF1D9BF0),
                        title: 'Call Helpdesk',
                        subtitle: '+91 1234567890 • Mon-Sat',
                        onTap:
                            widget.onCallHelpdesk ??
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Calling +91 1234567890...'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                      ),

                      const SizedBox(height: 14),

                      // Card 2: Email Support
                      _buildContactMethodCard(
                        icon: Icons.mail_outline_rounded,
                        iconColor: const Color(0xFF10B981),
                        badgeBgColor: const Color(
                          0xFF10B981,
                        ).withValues(alpha: 0.1),
                        badgeBorderColor: const Color(0xFF10B981),
                        title: 'Email Support',
                        subtitle: 'support@subsetu.com • 24/7',
                        onTap:
                            widget.onEmailSupport ??
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Opening email to support@subsetu.com...',
                                  ),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                      ),

                      const SizedBox(height: 28),

                      // Section Title: Submit a Ticket
                      const Text(
                        'Submit a Ticket',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Issue Category Label
                      const Text(
                        'Issue Category',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Dropdown: Issue Category
                      Container(
                        width: double.infinity,
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF222B3F),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            isExpanded: true,
                            dropdownColor: const Color(0xFF222B3F),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF94A3B8),
                            ),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            items: _categories.map((String cat) {
                              return DropdownMenuItem<String>(
                                value: cat,
                                child: Text(
                                  cat,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              if (newVal != null) {
                                setState(() {
                                  _selectedCategory = newVal;
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Message Details Label
                      const Text(
                        'Message Details',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Message Details Multiline Text Area
                      Container(
                        width: double.infinity,
                        height: 130,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF222B3F),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          controller: _messageController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: 'Describe your issue with Order #8847...',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF94A3B8),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Send Message Button
                      Center(
                        child: GestureDetector(
                          onTap: _handleSendMessage,
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(maxWidth: 320),
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFF59E0B,
                                  ).withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Send Message',
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

  Widget _buildContactMethodCard({
    required IconData icon,
    required Color iconColor,
    required Color badgeBgColor,
    required Color badgeBorderColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF222B3F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF334155), width: 1.5),
        ),
        child: Row(
          children: [
            // Circular Icon Badge
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: badgeBgColor,
                shape: BoxShape.circle,
                border: Border.all(color: badgeBorderColor, width: 1),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),

            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF94A3B8),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
