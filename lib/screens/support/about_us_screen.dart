import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class AboutUsScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onContactUsTap;
  final VoidCallback? onHelpSupportTap;
  final ValueChanged<int>? onNavTap;

  const AboutUsScreen({
    super.key,
    this.onBackTap,
    this.onMenuTap,
    this.onContactUsTap,
    this.onHelpSupportTap,
    this.onNavTap,
  });

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  int _currentNavIndex = 2; // Settings tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'About Us',
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
                  Navigator.pushNamed(context, '/menu');
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),

                      // Subtitle
                      const Text(
                        'Precision Machining & Supply Chain Network',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Header Profile Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF222B3F),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Circular Emblem
                            Container(
                              width: 86,
                              height: 86,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF1E2638),
                                border: Border.all(
                                  color: const Color(0xFFF5B800),
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFF5B800).withValues(alpha: 0.2),
                                    blurRadius: 14,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/subsetu_logo.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.precision_manufacturing_rounded,
                                        color: Color(0xFFF5B800),
                                        size: 42,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            const Text(
                              'SubSetu Industrial Platform',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Version Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1D9BF0).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF1D9BF0),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Version 1.0.0 • College Innovation Edition',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF1D9BF0),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Mission Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF222B3F),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Row(
                              children: [
                                Icon(
                                  Icons.rocket_launch_rounded,
                                  color: AppColors.primaryYellow,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Our Mission',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'SubSetu was engineered to eliminate transparency gaps in traditional industrial subcontracting. By integrating 4-stage Proof of Delivery (PoD) tracking, 100% material yield balancing, and bilateral machine capacity broadcasts, SubSetu connects suppliers and precision machine shops into a unified, accountable workflow.',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFFCBD5E1),
                                fontSize: 13,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Feature Cards (Figma format)
                      _buildFeatureTile(
                        icon: Icons.sync_alt_rounded,
                        accentColor: const Color(0xFF1D9BF0),
                        title: '4-Stage Supply Chain Sync',
                        description:
                            'Track jobs from Material Dispatched to PoD Received, Cutting in Progress, and Quality Assembly Ready.',
                      ),

                      const SizedBox(height: 12),

                      _buildFeatureTile(
                        icon: Icons.pie_chart_rounded,
                        accentColor: const Color(0xFF10B981),
                        title: 'Material Yield & Scrap Audit',
                        description:
                            'Accurate mathematical ledger balancing between raw issued weight, usable offcuts, and metal shavings.',
                      ),

                      const SizedBox(height: 12),

                      _buildFeatureTile(
                        icon: Icons.campaign_rounded,
                        accentColor: const Color(0xFFFAB115),
                        title: 'Bilateral Announcements',
                        description:
                            'Suppliers broadcast machine capacities; workshops post urgent RFQs and drawings with 1 tap.',
                      ),

                      const SizedBox(height: 12),

                      _buildFeatureTile(
                        icon: Icons.security_rounded,
                        accentColor: const Color(0xFFA855F7),
                        title: 'Role-Based Operational Security',
                        description:
                            'Dedicated interfaces for Enterprise Suppliers and Business Workshops with synchronized session state.',
                      ),

                      const SizedBox(height: 24),

                      // Quick Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: widget.onContactUsTap ??
                                  () {
                                    Navigator.pushNamed(context, AppRoutes.contactUs);
                                  },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryYellow,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryYellow.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.headset_mic_rounded,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'Contact Us',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: widget.onHelpSupportTap ??
                                  () {
                                    Navigator.pushNamed(context, AppRoutes.helpSupport);
                                  },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF222B3F),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: const Color(0xFF334155),
                                    width: 1.5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.help_outline_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'FAQs & Help',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildFeatureTile({
    required IconData icon,
    required Color accentColor,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF222B3F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF334155),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: accentColor,
                width: 1.2,
              ),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
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
                  description,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFF94A3B8),
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
