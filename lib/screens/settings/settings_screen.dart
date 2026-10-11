import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_header.dart';

class SettingsOptionData {
  final String title;
  final Widget icon;
  final VoidCallback? onTap;

  SettingsOptionData({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onHelpSupportTap;
  final VoidCallback? onAboutUsTap;
  final VoidCallback? onContactUsTap;
  final VoidCallback? onLogoutTap;

  const SettingsScreen({
    super.key,
    this.onBackTap,
    this.onHelpSupportTap,
    this.onAboutUsTap,
    this.onContactUsTap,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<SettingsOptionData> options = [
      SettingsOptionData(
        title: 'Help & Support',
        icon: const Icon(
          Icons.help_outline_rounded,
          color: Colors.white,
          size: 32,
        ),
        onTap: onHelpSupportTap ??
            () {
              Navigator.pushNamed(context, '/help-support');
            },
      ),
      SettingsOptionData(
        title: 'About Us ?',
        icon: const Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
          size: 32,
        ),
        onTap: onAboutUsTap ??
            () {
              Navigator.pushNamed(context, '/about-us');
            },
      ),
      SettingsOptionData(
        title: 'contact Us',
        icon: Stack(
          alignment: Alignment.center,
          children: const [
            Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 28,
            ),
            Positioned(
              right: 0,
              bottom: 2,
              child: Text(
                '?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onTap: onContactUsTap ??
            () {
              Navigator.pushNamed(context, '/contact-us');
            },
      ),
      SettingsOptionData(
        title: 'Logout',
        icon: const Icon(
          Icons.logout_rounded,
          color: Colors.white,
          size: 32,
        ),
        onTap: onLogoutTap ??
            () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: AppColors.cardDark,
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'Are you sure you want to log out?',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: const Text('Logout', style: TextStyle(color: AppColors.primaryYellow)),
                    ),
                  ],
                ),
              );
            },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Settings',
        onBack: onBackTap ?? () => Navigator.of(context).maybePop(),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 402),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...options.map((opt) => _buildOptionRow(opt)),
                        const SizedBox(height: 40),
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

  Widget _buildOptionRow(SettingsOptionData opt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: InkWell(
        onTap: opt.onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Row(
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: Center(child: opt.icon),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Text(
                  opt.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.textWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
