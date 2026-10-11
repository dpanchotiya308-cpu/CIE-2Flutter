import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class NewPasswordScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSubmit;

  const NewPasswordScreen({
    super.key,
    this.onBackTap,
    this.onSubmit,
  });

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
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
                    padding: const EdgeInsets.symmetric(horizontal: 38),
                    child: IntrinsicHeight(
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
                                      'New Password',
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

                          const SizedBox(height: 120),

                          // Field 1: Enter New password Label
                          const Text(
                            'Enter New password',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.textWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Rectangle 16: Enter New password Input Pill
                          Container(
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B97A9),
                              borderRadius: BorderRadius.circular(62),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: _newPasswordController,
                              obscureText: true,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: AppColors.textWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: '8 Symbls at least',
                                hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 38),

                          // Field 2: Confirm Password Label
                          const Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.textWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Rectangle 17: Confirm Password Input Pill
                          Container(
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B97A9),
                              borderRadius: BorderRadius.circular(62),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: AppColors.textWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.0,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: '********',
                                hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 56),

                          // Submit Button (Figma: width 225px, height 67px, radius 62px)
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onSubmit != null) {
                                  widget.onSubmit!();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Password updated successfully!'),
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
                                  'Submit',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: AppColors.textBlack,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),
                          const SizedBox(height: 40),
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
}
