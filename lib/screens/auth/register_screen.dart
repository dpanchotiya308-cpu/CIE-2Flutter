import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/user_session_service.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback? onSubmit;
  final VoidCallback? onSignInTap;
  final VoidCallback? onBackTap;

  const RegisterScreen({
    super.key,
    this.onSubmit,
    this.onSignInTap,
    this.onBackTap,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Top Header with Yellow Back Arrow & Title
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
                              child: Container(
                                padding: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color(0xFFF5B800),
                                  size: 22,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                'Create Your Account',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.textWhite,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Field 1: Full Name
                        CustomTextField(
                          label: 'Full Name',
                          hintText: 'Georgia Alfaro',
                          controller: _fullNameController,
                        ),

                        const SizedBox(height: 18),

                        // Field 2: Email
                        CustomTextField(
                          label: 'Email',
                          hintText: 'abc@gmail.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 18),

                        // Field 3: Password
                        CustomTextField(
                          label: 'Password',
                          hintText: 'Abc@123',
                          isPassword: true,
                          controller: _passwordController,
                        ),

                        const SizedBox(height: 18),

                        // Field 4: Conform Password (spelled as in Figma)
                        CustomTextField(
                          label: 'Conform Password',
                          hintText: 'Abc@123',
                          isPassword: true,
                          controller: _confirmPasswordController,
                        ),

                        const SizedBox(height: 18),

                        // Field 5: Phone Number
                        CustomTextField(
                          label: 'Phone Number',
                          hintText: '1234567890',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                        ),

                        const SizedBox(height: 18),

                        // Field 6: Company Name
                        CustomTextField(
                          label: 'Company Name',
                          hintText: 'Excel machinery pvt.ltd',
                          controller: _companyController,
                        ),

                        const SizedBox(height: 34),

                        // Submit Button (Figma: width 240px, height 71px, radius 62px)
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              UserSessionService().updateProfile(
                                fullName: _fullNameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                company: _companyController.text,
                              );
                              if (widget.onSubmit != null) {
                                widget.onSubmit!();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Account created & profile saved!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: 240,
                              height: 60,
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
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 26),

                        // Bottom Navigation: Already have an account ? Sign In
                        Center(
                          child: GestureDetector(
                            onTap: widget.onSignInTap ?? () => Navigator.of(context).maybePop(),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Already have an account ? ',
                                      style: TextStyle(
                                        color: AppColors.textWhite,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Sign In',
                                      style: TextStyle(
                                        color: AppColors.primaryYellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
}
