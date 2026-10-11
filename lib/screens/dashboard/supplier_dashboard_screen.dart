import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class SupplierDashboardScreen extends StatefulWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onMenuTap;
  final ValueChanged<int>? onNavTap;
  final VoidCallback? onViewMoreCnc;
  final VoidCallback? onViewMoreCutting;

  const SupplierDashboardScreen({
    super.key,
    this.onProfileTap,
    this.onMenuTap,
    this.onNavTap,
    this.onViewMoreCnc,
    this.onViewMoreCutting,
  });

  @override
  State<SupplierDashboardScreen> createState() => _SupplierDashboardScreenState();
}

class _SupplierDashboardScreenState extends State<SupplierDashboardScreen> {
  int _currentNavIndex = 0;
  bool _isCncExpanded = false;
  bool _isCuttingExpanded = false;

  final String _cncDescription =
      'High precision 5-axis CNC machining & turning.\n'
      'Accuracy up to ±0.005 mm for steel and aluminum.\n'
      'Fast turnaround available for batch work orders.';

  final String _cuttingDescription =
      'High-speed 6kW CNC Fiber Laser & Plasma cutting.\n'
      'Up to 25mm thickness capacity with burr-free finish.\n'
      'Daily yield capacity up to 1,500 kg per day.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader.dashboard(
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),

                        // Section 1: Best CNC Technology
                        _buildTechCard(
                          imageAsset: 'assets/images/cnc_tech_logo.png',
                          fallbackIcon: Icons.precision_manufacturing_rounded,
                          title: 'Logo Text Here technology pty.ltd\nBest CNC Technology',
                          isExpanded: _isCncExpanded,
                          description: _cncDescription,
                          onToggleExpand: () {
                            setState(() {
                              _isCncExpanded = !_isCncExpanded;
                            });
                            widget.onViewMoreCnc?.call();
                          },
                        ),

                        const SizedBox(height: 36),

                        // Section 2: Best Cutting Technology
                        _buildTechCard(
                          imageAsset: 'assets/images/cutting_tech_logo.png',
                          fallbackIcon: Icons.handyman_rounded,
                          title: 'Logo Text Here technology pty.ltd\nBest Cutting Technology',
                          isExpanded: _isCuttingExpanded,
                          description: _cuttingDescription,
                          onToggleExpand: () {
                            setState(() {
                              _isCuttingExpanded = !_isCuttingExpanded;
                            });
                            widget.onViewMoreCutting?.call();
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

  Widget _buildTechCard({
    required String imageAsset,
    required IconData fallbackIcon,
    required String title,
    required bool isExpanded,
    required String description,
    required VoidCallback onToggleExpand,
  }) {
    return Column(
      children: [
        // Circular Emblem (Figma: width 181px, height 181px)
        Container(
          width: 181,
          height: 181,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    fallbackIcon,
                    size: 72,
                    color: AppColors.primaryYellow,
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Title (Figma: Inter 700, 16px, line-height 19px, color #000000)
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),

        const SizedBox(height: 14),

        // View More / View Less Row (Figma: Inter 700, 20px, #000000 + lsicon:down-filled)
        InkWell(
          onTap: onToggleExpand,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isExpanded ? 'View Less' : 'View More',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                  size: 26,
                ),
              ],
            ),
          ),
        ),

        // Simple normal 2-3 lines description
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF64748B),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
