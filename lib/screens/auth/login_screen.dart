import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  final ValueChanged<String>? onRoleLogin;
  final VoidCallback? onSignUpTap;
  final VoidCallback? onForgotPasswordTap;

  const LoginScreen({
    super.key,
    this.onLoginSuccess,
    this.onRoleLogin,
    this.onSignUpTap,
    this.onForgotPasswordTap,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'Supplier'; // 'Supplier' or 'Business'

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (widget.onRoleLogin != null) {
      widget.onRoleLogin!(_selectedRole);
    } else if (widget.onLoginSuccess != null) {
      widget.onLoginSuccess!();
    } else {
      if (_selectedRole == 'Supplier') {
        Navigator.pushNamed(context, '/supplier-dashboard');
      } else {
        Navigator.pushNamed(context, '/business-home');
      }
    }
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
                          const SizedBox(height: 32),

                          // SubSetu Circular Logo
                          _buildLogo(),

                          const SizedBox(height: 20),

                          // Login to Account Title
                          const Text(
                            'Login to Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: AppColors.textWhite,
                              fontSize: 34,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Role Selector: Supplier / Business
                          _buildRoleSelector(),

                          const SizedBox(height: 28),

                          // Email Field
                          CustomTextField(
                            label: 'Email',
                            hintText: 'Enter your Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            icon: const Icon(
                              Icons.mail_outline_rounded,
                              size: 20,
                              color: AppColors.textBlack,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Password Field
                          CustomTextField(
                            label: 'Password',
                            hintText: 'Enter your Password',
                            isPassword: true,
                            controller: _passwordController,
                            icon: const Icon(
                              Icons.lock_outline_rounded,
                              size: 20,
                              color: AppColors.textBlack,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Forgot password? Link
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: widget.onForgotPasswordTap,
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.primaryYellow,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Login Button
                          GestureDetector(
                            onTap: _handleLogin,
                            child: Container(
                              width: 140,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.primaryYellow,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryYellow.withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.textBlack,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          const SizedBox(height: 24),

                          // Need an Account ? Sign Up
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: GestureDetector(
                              onTap: widget.onSignUpTap,
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
                                      text: 'Need an Account ? ',
                                      style: TextStyle(
                                        color: AppColors.textWhite,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Sign Up',
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

  Widget _buildRoleSelector() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF222B3F),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: const Color(0xFF334155),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Supplier Option
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRole = 'Supplier';
                });
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedRole == 'Supplier'
                      ? AppColors.primaryYellow
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.precision_manufacturing_outlined,
                      size: 18,
                      color: _selectedRole == 'Supplier'
                          ? Colors.black
                          : const Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Supplier',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _selectedRole == 'Supplier'
                            ? Colors.black
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Business Option
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRole = 'Business';
                });
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedRole == 'Business'
                      ? AppColors.primaryYellow
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business_rounded,
                      size: 18,
                      color: _selectedRole == 'Business'
                          ? Colors.black
                          : const Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Business',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _selectedRole == 'Business'
                            ? Colors.black
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFF222B3F),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFF5B800),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/subsetu_logo.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.precision_manufacturing_rounded,
                    color: Color(0xFFFAB115),
                    size: 36,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'SubSetu',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
