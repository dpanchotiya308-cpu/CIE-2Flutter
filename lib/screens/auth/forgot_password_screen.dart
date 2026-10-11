import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onBackToSignIn;
  final VoidCallback? onSend;
  final VoidCallback? onSignUpTap;

  const ForgotPasswordScreen({
    super.key,
    this.onBackTap,
    this.onBackToSignIn,
    this.onSend,
    this.onSignUpTap,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),

                          // Top Navigation Bar (Yellow Back Chevron & Forgot Password Title)
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
                                      'Forgot password',
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

                          const SizedBox(height: 140),

                          // Enter Email Address Title
                          const Text(
                            'Enter Email Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.textWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Email Input Pill (Figma: width 316px, height 64px, radius 62px, rgba(255,255,255,0.5))
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B97A9),
                              borderRadius: BorderRadius.circular(62),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: AppColors.textWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'abc@gmail.com',
                                hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFFE2E8F0),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Back to Sign In Link
                          GestureDetector(
                            onTap: widget.onBackToSignIn ?? () => Navigator.of(context).maybePop(),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Back to ',
                                    style: TextStyle(
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                      color: AppColors.primaryYellow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 48),

                          // Send Button (Figma: width 225px, height 67px, radius 62px, #FAB115)
                          GestureDetector(
                            onTap: () {
                              if (widget.onSend != null) {
                                widget.onSend!();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Verification code sent to email!'),
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
                                'Send',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF1E1B13),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          const SizedBox(height: 40),

                          // Bottom Prompt: Don't have an account ? / Sign Up
                          Column(
                            children: [
                              const Text(
                                'Don’t have an account ?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.textWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: widget.onSignUpTap,
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: AppColors.primaryYellow,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 36),
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
