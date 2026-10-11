import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/user_session_service.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_header.dart';

class BusinessProfileScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onEditProfile;
  final VoidCallback? onAppSettingsTap;
  final VoidCallback? onMachineCapabilitiesTap;
  final ValueChanged<int>? onNavTap;

  const BusinessProfileScreen({
    super.key,
    this.onBackTap,
    this.onMenuTap,
    this.onEditProfile,
    this.onAppSettingsTap,
    this.onMachineCapabilitiesTap,
    this.onNavTap,
  });

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  int _currentNavIndex = 2; // 'Settings' tab

  @override
  void initState() {
    super.initState();
    UserSessionService().addListener(_onSessionChanged);
  }

  @override
  void dispose() {
    UserSessionService().removeListener(_onSessionChanged);
    super.dispose();
  }

  void _onSessionChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  String _getInitials(String company) {
    final trimmed = company.trim();
    if (trimmed.isEmpty) return 'EM';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return trimmed.substring(0, trimmed.length >= 2 ? 2 : 1).toUpperCase();
  }

  void _showEditProfileSheet(BuildContext context) {
    final session = UserSessionService();
    final profile = session.currentProfile;

    final companyController = TextEditingController(text: profile.company);
    final ownerController = TextEditingController(text: profile.fullName);
    final emailController = TextEditingController(text: profile.email);
    final phoneController = TextEditingController(text: profile.phone);
    final Set<String> selectedCapabilities = Set<String>.from(profile.capabilities);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2D3F63),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 44,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF94A3B8).withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Edit Business Profile',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: Colors.white),
                            onPressed: () => Navigator.pop(ctx),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildEditField(
                        label: 'Workshop / Company Name',
                        controller: companyController,
                        hint: 'e.g., Excel Machinery pvt.ltd',
                      ),
                      const SizedBox(height: 14),
                      _buildEditField(
                        label: 'Owner / Contact Full Name',
                        controller: ownerController,
                        hint: 'e.g., Georgia Alfaro',
                      ),
                      const SizedBox(height: 14),
                      _buildEditField(
                        label: 'Email Address',
                        controller: emailController,
                        hint: 'e.g., excelmachinery@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 14),
                      _buildEditField(
                        label: 'Phone Number',
                        controller: phoneController,
                        hint: 'e.g., 1234567890',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Machine Capabilities',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: ['CNC', 'Lathe', 'Laser', 'Fabrication', 'Manual Milling'].map((tag) {
                          final isSelected = selectedCapabilities.contains(tag);
                          return GestureDetector(
                            onTap: () {
                              setSheetState(() {
                                if (isSelected) {
                                  selectedCapabilities.remove(tag);
                                } else {
                                  selectedCapabilities.add(tag);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryYellow
                                    : const Color(0xFF222B3F),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryYellow
                                      : const Color(0xFF334155),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: isSelected ? Colors.black : Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            session.updateProfile(
                              company: companyController.text,
                              fullName: ownerController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              capabilities: selectedCapabilities.toList(),
                            );
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Business profile updated successfully!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryYellow,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEditField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Color(0xFF94A3B8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF222B3F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF64748B),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = UserSessionService().currentProfile;
    final initials = _getInitials(profile.company);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Business Profile',
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
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      // Profile Avatar with Dynamic Initials
                      Center(
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF222B3F),
                            border: Border.all(
                              color: const Color(0xFF1D9BF0),
                              width: 2.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            initials,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF1D9BF0),
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Business Name from Session
                      Text(
                        profile.company.isNotEmpty
                            ? profile.company
                            : 'Excel Machinery pvt.ltd',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Email & Phone Subtitle from Session
                      Text(
                        '${profile.email} | ${profile.phone}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Edit Profile Button
                      GestureDetector(
                        onTap: () {
                          if (widget.onEditProfile != null) {
                            widget.onEditProfile!();
                          }
                          _showEditProfileSheet(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF222B3F),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF334155),
                              width: 1.5,
                            ),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ==========================================
                      // REGISTERED DETAILS SECTION (Below Edit Profile)
                      // ==========================================

                      // Detail 1: Company / Workshop Name
                      _buildDetailTile(
                        icon: Icons.storefront_rounded,
                        label: 'Workshop / Company Name',
                        value: profile.company.isNotEmpty
                            ? profile.company
                            : 'Excel Machinery pvt.ltd',
                      ),

                      // Detail 2: Owner Full Name
                      _buildDetailTile(
                        icon: Icons.person_outline_rounded,
                        label: 'Owner Full Name',
                        value: profile.fullName.isNotEmpty
                            ? profile.fullName
                            : 'Georgia Alfaro',
                      ),

                      // Detail 3: Email Address
                      _buildDetailTile(
                        icon: Icons.mail_outline_rounded,
                        label: 'Email Address',
                        value: profile.email.isNotEmpty
                            ? profile.email
                            : 'excelmachinery@gmail.com',
                      ),

                      // Detail 4: Phone Number
                      _buildDetailTile(
                        icon: Icons.phone_outlined,
                        label: 'Phone Number',
                        value: profile.phone.isNotEmpty
                            ? profile.phone
                            : '1234567890',
                      ),

                      // Detail 5: Machine Capabilities Tagging
                      _buildDetailTile(
                        icon: Icons.precision_manufacturing_rounded,
                        label: 'Machine Capabilities',
                        value: profile.capabilities.isNotEmpty
                            ? profile.capabilities.join(' • ')
                            : 'CNC • Lathe',
                      ),

                      const SizedBox(height: 12),

                      // Option: App Settings & Language
                      _buildOptionTile(
                        title: 'App Settings & Language',
                        onTap: widget.onAppSettingsTap ??
                            () {
                              Navigator.pushNamed(context, '/settings');
                            },
                      ),

                      const SizedBox(height: 28),
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

  Widget _buildDetailTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF222B3F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF334155),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF2D3F63),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF1D9BF0).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1D9BF0),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF222B3F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF334155),
            width: 1,
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
