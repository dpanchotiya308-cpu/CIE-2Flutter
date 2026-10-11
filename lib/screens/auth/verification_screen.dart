import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class VerificationScreen extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onVerify;
  final VoidCallback? onResendTap;

  const VerificationScreen({
    super.key,
    this.onBackTap,
    this.onVerify,
    this.onResendTap,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(text: ['4', '2', '5', '9'][index]),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
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
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),

                          // Top Navigation Bar (Yellow Back Chevron & Verification Title)
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
                                      'Verification',
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

                          // Enter Verification Code Title
                          const Text(
                            'Enter Verification Code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.textWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 50),

                          // 4 Circular OTP Fields (Group 3: Ellipse 2, 3, 4, 5 - #D9D9D9 79px)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(4, (index) => _buildOtpCircle(index)),
                          ),

                          const SizedBox(height: 55),

                          // if you didn't receive a code! Resend
                          GestureDetector(
                            onTap: widget.onResendTap ??
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Verification code resent!')),
                                  );
                                },
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'if you didn’t receive a code! ',
                                    style: TextStyle(
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Resend',
                                    style: TextStyle(
                                      color: AppColors.primaryYellow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 55),

                          // Verify Button (Rectangle 15: width 225px, height 67px, radius 62px)
                          GestureDetector(
                            onTap: () {
                              if (widget.onVerify != null) {
                                widget.onVerify!();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Code verified successfully!'),
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
                                'Verify',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.textBlack,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
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

  Widget _buildOtpCircle(int index) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        color: AppColors.iconBadgeBg, // #D9D9D9
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontFamily: 'Inter',
          color: AppColors.textBlack,
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
