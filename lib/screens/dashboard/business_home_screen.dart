import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class BusinessHomeScreen extends StatefulWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onMenuTap;
  final ValueChanged<int>? onNavTap;
  final VoidCallback? onOrderTap;

  const BusinessHomeScreen({
    super.key,
    this.onProfileTap,
    this.onMenuTap,
    this.onNavTap,
    this.onOrderTap,
  });

  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader.dashboard(
        title: 'Business Home',
        onProfileTap: widget.onProfileTap,
        onMenuTap: widget.onMenuTap,
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
        top: false,
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subtitle
                        const Text(
                          'manage your cutting jobs',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 2x2 Metric Cards Grid
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Total Job',
                                value: '24',
                                valueColor: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Pending (Padding)',
                                value: '10',
                                valueColor: const Color(0xFFF59E0B),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricCard(
                                title: 'In Progress',
                                value: '08',
                                valueColor: const Color(0xFF1D9BF0),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Ready',
                                value: '06',
                                valueColor: const Color(0xFF10B981),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Job Inbox (New Cards) Heading
                        const Text(
                          'Job Inbox (New Cards)',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Job Card 1: Order #1 - Tech Corp Inc.
                        _buildJobCard(
                          title: 'Order #1 - Tech Corp Inc.',
                          date: 'Date: 18 Feb 2026',
                          onTap: widget.onOrderTap ??
                              () {
                                Navigator.pushNamed(context, '/order-details');
                              },
                        ),

                        const SizedBox(height: 16),

                        // Job Card 2: Order #2 - Alpha Ind.
                        _buildJobCard(
                          title: 'Order #2 - Alpha Ind.',
                          date: 'Date: 17 Feb 2026',
                          onTap: widget.onOrderTap ??
                              () {
                                Navigator.pushNamed(context, '/order-details');
                              },
                        ),

                        const SizedBox(height: 30),
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF222B3F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              color: valueColor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard({
    required String title,
    required String date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF222B3F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: AppColors.textWhite,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              date,
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
    );
  }
}
