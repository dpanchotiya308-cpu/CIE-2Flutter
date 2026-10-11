import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/user_session_service.dart';
import '../../widgets/app_header.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onUpdate;

  const ProfileScreen({
    super.key,
    this.onBackTap,
    this.onUpdate,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _companyController;

  @override
  void initState() {
    super.initState();
    final profile = UserSessionService().currentProfile;
    _fullNameController = TextEditingController(text: profile.fullName);
    _emailController = TextEditingController(text: profile.email);
    _phoneController = TextEditingController(text: profile.phone);
    _companyController = TextEditingController(text: profile.company);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final company = _companyController.text.trim();

    if (fullName.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in required fields'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    UserSessionService().updateProfile(
      fullName: fullName,
      email: email,
      phone: phone,
      company: company,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile for $fullName updated successfully!'),
        backgroundColor: const Color(0xFFF59E0B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    widget.onUpdate?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Profile',
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
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // Center Avatar (Figma: width 116px, height 116px)
                        Center(
                          child: Container(
                            width: 116,
                            height: 116,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFD9D9D9),
                              border: Border.all(
                                color: const Color(0xFFFAB115),
                                width: 2.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              'assets/images/user_avatar.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.account_circle,
                                  size: 116,
                                  color: Colors.black,
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Field 1: Full Name
                        _buildField(
                          label: 'Full Name',
                          controller: _fullNameController,
                          hintText: 'Georgia Alfaro',
                        ),

                        const SizedBox(height: 20),

                        // Field 2: Enter Email Address
                        _buildField(
                          label: 'Enter Email Address',
                          controller: _emailController,
                          hintText: 'abc@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        // Field 3: Phone Number
                        _buildField(
                          label: 'Phone Number',
                          controller: _phoneController,
                          hintText: '1234567890',
                          keyboardType: TextInputType.phone,
                        ),

                        const SizedBox(height: 20),

                        // Field 4: Company Name (Registered details connected)
                        _buildField(
                          label: 'Company Name',
                          controller: _companyController,
                          hintText: 'Excel machinery pvt.ltd',
                        ),

                        const SizedBox(height: 40),

                        // Update Button (Figma: width 225px, height 62px, radius 62px)
                        Center(
                          child: GestureDetector(
                            onTap: _handleUpdate,
                            child: Container(
                              width: 225,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.primaryYellow,
                                borderRadius: BorderRadius.circular(62),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryYellow
                                        .withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.textBlack,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 36),
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

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hintText,
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
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF8B97A9),
            borderRadius: BorderRadius.circular(62),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: AppColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFFE2E8F0),
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
