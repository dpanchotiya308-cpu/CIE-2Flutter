import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

enum UserRole { enterpriseSupplier, business }

class RoleSelectionScreen extends StatefulWidget {
  final ValueChanged<UserRole>? onRoleSelected;
  final VoidCallback? onContinue;

  const RoleSelectionScreen({
    super.key,
    this.onRoleSelected,
    this.onContinue,
  });

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole _selectedRole = UserRole.enterpriseSupplier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 70),

                          // Select Your Role Title
                          const Text(
                            'Select Your Role',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.textWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Subtitle: How do you want to use SubSetu?
                          const Text(
                            'How do you want to use SubSetu?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.textMuted,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Role 1: Enterprise Supplier Card
                          _buildRoleCard(
                            role: UserRole.enterpriseSupplier,
                            title: 'Enterprise Supplier',
                            description: 'Register orders & track material workflow',
                            iconAsset: 'assets/images/enterprise_supplier_icon.png',
                            fallbackIcon: Icons.apartment_rounded,
                          ),

                          const SizedBox(height: 24),

                          // Role 2: Business Card
                          _buildRoleCard(
                            role: UserRole.business,
                            title: 'Business',
                            description: 'Accept jobs & upload PoD production sync',
                            iconAsset: 'assets/images/business_icon.png',
                            fallbackIcon: Icons.business_center_rounded,
                          ),

                          const Spacer(),

                          const SizedBox(height: 40),

                          // Continue Button (Figma: #FAB115, Inter 700)
                          GestureDetector(
                            onTap: () {
                              if (widget.onRoleSelected != null) {
                                widget.onRoleSelected!(_selectedRole);
                              }
                              if (widget.onContinue != null) {
                                widget.onContinue!();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Selected: ${_selectedRole == UserRole.enterpriseSupplier ? "Enterprise Supplier" : "Business"}',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 54,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryYellow,
                                borderRadius: BorderRadius.circular(27),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.textBlack,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 48),
                        ],
                      ),
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

  Widget _buildRoleCard({
    required UserRole role,
    required String title,
    required String description,
    required String iconAsset,
    required IconData fallbackIcon,
  }) {
    final bool isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: isSelected ? AppColors.selectedBlue : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Stack(
          children: [
            // Top Right Checkmark Indicator
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.selectedBlue : const Color(0xFF28364F),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: const Color(0xFF3B4861),
                          width: 1.5,
                        ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),

            // Card Body Content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 6),

                // Icon Container
                SizedBox(
                  height: 62,
                  child: Image.asset(
                    iconAsset,
                    height: 58,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        fallbackIcon,
                        size: 48,
                        color: Colors.white,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                // Subtitle / Description
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
