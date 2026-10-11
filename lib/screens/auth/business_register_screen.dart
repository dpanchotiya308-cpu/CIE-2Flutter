import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/user_session_service.dart';

class BusinessRegisterScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onCreateProfile;

  const BusinessRegisterScreen({
    super.key,
    this.onBackTap,
    this.onCreateProfile,
  });

  @override
  State<BusinessRegisterScreen> createState() => _BusinessRegisterScreenState();
}

class _BusinessRegisterScreenState extends State<BusinessRegisterScreen> {
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Set<String> _selectedCapabilities = {'CNC', 'Lathe'};

  @override
  void dispose() {
    _shopNameController.dispose();
    _ownerNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleCapability(String tag) {
    setState(() {
      if (_selectedCapabilities.contains(tag)) {
        _selectedCapabilities.remove(tag);
      } else {
        _selectedCapabilities.add(tag);
      }
    });
  }

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
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),

                        // Top Header (Yellow Back Chevron, Title & Subtitle)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
                              child: Container(
                                padding: const EdgeInsets.only(right: 12, top: 2, bottom: 4),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color(0xFFF5B800),
                                  size: 22,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Business Register',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColors.textWhite,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Create your SubSetu Partner Profile',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF94A3B8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Field 1: Workshop / Shop Name
                        _buildDarkField(
                          label: 'Workshop / Shop Name',
                          hintText: 'e.g., Excel Machinery',
                          controller: _shopNameController,
                        ),

                        const SizedBox(height: 16),

                        // Field 2: Owner Full Name
                        _buildDarkField(
                          label: 'Owner Full Name',
                          hintText: 'Enter your name',
                          controller: _ownerNameController,
                        ),

                        const SizedBox(height: 16),

                        // Field 3: Email Address
                        _buildDarkField(
                          label: 'Email Address',
                          hintText: 'Enter your Email Address',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        // Field 4: Phone Number
                        _buildDarkField(
                          label: 'Phone Number',
                          hintText: 'Enter your Phone Number',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                        ),

                        const SizedBox(height: 16),

                        // Field 5: Password
                        _buildDarkField(
                          label: 'Password',
                          hintText: 'Enter your Password',
                          controller: _passwordController,
                          isPassword: true,
                        ),

                        const SizedBox(height: 24),

                        // Machine Capabilities Tagging Section
                        const Text(
                          'Machine Capabilities Tagging',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Select all equipment available at your unit',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF94A3B8),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Responsive Wrap for Capabilities Tags
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildTag('CNC', minWidth: 68),
                            _buildTag('Lathe', minWidth: 72),
                            _buildTag('Laser', minWidth: 78),
                            _buildTag('Fabrication', minWidth: 110),
                            _buildTag('Manual Miling', minWidth: 128),
                          ],
                        ),

                        const SizedBox(height: 36),

                        // Create Business Profile Button
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              UserSessionService().updateProfile(
                                company: _shopNameController.text,
                                fullName: _ownerNameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                capabilities: _selectedCapabilities.toList(),
                              );
                              if (widget.onCreateProfile != null) {
                                widget.onCreateProfile!();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Business Profile Created successfully!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF59E0B),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Create Business Profile',
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

  Widget _buildDarkField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: AppColors.textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF222B3F),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF334155), width: 1.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF94A3B8),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String title, {required double minWidth}) {
    final bool isSelected = _selectedCapabilities.contains(title);

    return GestureDetector(
      onTap: () => _toggleCapability(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        constraints: BoxConstraints(minWidth: minWidth),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF59E0B).withValues(alpha: 0.25) : const Color(0xFF222B3F),
          borderRadius: BorderRadius.circular(100),
          border: isSelected ? Border.all(color: const Color(0xFFF59E0B), width: 1.2) : null,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            color: isSelected ? const Color(0xFFF59E0B) : Colors.white,
            fontSize: isSelected ? 15 : 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
