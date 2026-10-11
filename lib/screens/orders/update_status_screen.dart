import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class UpdateStatusScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onMarkReady;
  final ValueChanged<int>? onNavTap;

  const UpdateStatusScreen({
    super.key,
    this.onBackTap,
    this.onMenuTap,
    this.onMarkReady,
    this.onNavTap,
  });

  @override
  State<UpdateStatusScreen> createState() => _UpdateStatusScreenState();
}

class _UpdateStatusScreenState extends State<UpdateStatusScreen> {
  int _currentNavIndex = 1; // 'Orders' tab
  bool _isStage1Dispatched = true;
  bool _isStage2Received = true;
  bool _isStage3Cutting = true;
  bool _isStage4Ready = false;

  void _handleMarkReady() {
    setState(() {
      _isStage4Ready = !_isStage4Ready;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isStage4Ready
              ? 'Order #1 marked as Ready for Quality Assembly!'
              : 'Stage 4 status reset',
        ),
        backgroundColor: const Color(0xFFF59E0B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    widget.onMarkReady?.call();
  }

  void _showStageToast(String stageName, bool isChecked) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isChecked
              ? '$stageName marked as Completed'
              : '$stageName marked as Incomplete',
        ),
        backgroundColor: isChecked ? const Color(0xFFF59E0B) : const Color(0xFF334155),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Update Status',
        subtitle: 'Order #1 - 4-Stage Sync',
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
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 36),

                      // Stage 1: Material Dispatched (Interactive Checkbox)
                      _buildStageItem(
                        isChecked: _isStage1Dispatched,
                        title: 'Material Dispatched',
                        subtitle: 'By Supplier: 18 Feb, 10:00 AM',
                        titleColor: _isStage1Dispatched ? Colors.white : const Color(0xFF94A3B8),
                        onTap: () {
                          setState(() {
                            _isStage1Dispatched = !_isStage1Dispatched;
                          });
                          _showStageToast('Material Dispatched', _isStage1Dispatched);
                        },
                      ),

                      const SizedBox(height: 38),

                      // Stage 2: Material Received (Interactive Checkbox)
                      _buildStageItem(
                        isChecked: _isStage2Received,
                        title: 'Material Received',
                        subtitle: 'Acknowledged via PoD',
                        titleColor: _isStage2Received ? Colors.white : const Color(0xFF94A3B8),
                        onTap: () {
                          setState(() {
                            _isStage2Received = !_isStage2Received;
                          });
                          _showStageToast('Material Received', _isStage2Received);
                        },
                      ),

                      const SizedBox(height: 38),

                      // Stage 3: Cutting In Progress (Interactive Checkbox)
                      _buildStageItem(
                        isChecked: _isStage3Cutting,
                        title: 'Cutting In Progress',
                        subtitle: 'Currently active stage',
                        titleColor: _isStage3Cutting
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFF94A3B8),
                        onTap: () {
                          setState(() {
                            _isStage3Cutting = !_isStage3Cutting;
                          });
                          _showStageToast('Cutting In Progress', _isStage3Cutting);
                        },
                      ),

                      const SizedBox(height: 38),

                      // Stage 4: Ready for Quality Assembly (Interactive Checkbox)
                      _buildStageItem(
                        isChecked: _isStage4Ready,
                        title: 'Ready for Quality Assembly',
                        subtitle: _isStage4Ready ? 'Stage completed' : null,
                        titleColor: _isStage4Ready
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFF94A3B8),
                        onTap: () {
                          setState(() {
                            _isStage4Ready = !_isStage4Ready;
                          });
                          _showStageToast('Quality Assembly', _isStage4Ready);
                          if (_isStage4Ready) {
                            widget.onMarkReady?.call();
                          }
                        },
                      ),

                      const SizedBox(height: 52),

                      // Action Button: 1-Tap: Mark as Ready
                      Center(
                        child: GestureDetector(
                          onTap: _handleMarkReady,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: double.infinity,
                            constraints: const BoxConstraints(maxWidth: 320),
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _isStage4Ready
                                  ? 'Marked as Ready'
                                  : '1-Tap: Mark as Ready',
                              style: const TextStyle(
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

  Widget _buildStageItem({
    required bool isChecked,
    required String title,
    String? subtitle,
    required Color titleColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox Icon (Figma: Vector with rounded box, manually clickable)
          Container(
            width: 26,
            height: 26,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: isChecked ? const Color(0xFFF59E0B) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isChecked ? const Color(0xFFF59E0B) : const Color(0xFFF59E0B),
                width: 2.2,
              ),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: Colors.white,
                  )
                : null,
          ),

          const SizedBox(width: 22),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF94A3B8),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.25,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
