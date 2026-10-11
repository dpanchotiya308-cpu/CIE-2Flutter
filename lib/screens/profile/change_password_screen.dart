import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onUpdate;

  const ChangePasswordScreen({
    super.key,
    this.onBackTap,
    this.onUpdate,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'abc@gmail.com');
  final TextEditingController _currentPasswordController = TextEditingController(text: 'acb@123');
  final TextEditingController _newPasswordController = TextEditingController(text: 'bcd@123');
  final TextEditingController _confirmPasswordController = TextEditingController(text: 'bcd@123');

  @override
  void dispose() {
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),

                        // Top Navigation Bar (Yellow Back Chevron & Title)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
                              child: Container(
                                padding: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color(0xFFF5B800),
                                  size: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 32),
                                  child: const Text(
                                    'Change Password',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColors.textWhite,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 38),

                        // Field 1: Enter Email Address
                        _buildField(
                          label: 'Enter Email Address',
                          controller: _emailController,
                          hintText: 'abc@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        // Field 2: Current Password
                        _buildField(
                          label: 'Current Password',
                          controller: _currentPasswordController,
                          hintText: 'acb@123',
                          isPassword: true,
                        ),

                        const SizedBox(height: 20),

                        // Field 3: New Password
                        _buildField(
                          label: 'New Password',
                          controller: _newPasswordController,
                          hintText: 'bcd@123',
                          isPassword: true,
                        ),

                        const SizedBox(height: 20),

                        // Field 4: Confirm Password
                        _buildField(
                          label: 'Confirm Password',
                          controller: _confirmPasswordController,
                          hintText: 'bcd@123',
                          isPassword: true,
                        ),

                        const SizedBox(height: 44),

                        // Update Button (Figma: width 225px, height 67px, radius 62px)
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (widget.onUpdate != null) {
                                widget.onUpdate!();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password changed successfully!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: 225,
                              height: 62,
                              decoration: BoxDecoration(
                                color: AppColors.primaryYellow,
                                borderRadius: BorderRadius.circular(62),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.textBlack,
                                  fontSize: 26,
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
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 62,
          decoration: BoxDecoration(
            color: const Color(0xFF8B97A9),
            borderRadius: BorderRadius.circular(62),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 26),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: AppColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w300,
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
