import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/app_header.dart';

class MenuItemData {
  final String title;
  final IconData icon;
  final String? routeName;
  final VoidCallback? onTap;

  MenuItemData({
    required this.title,
    required this.icon,
    this.routeName,
    this.onTap,
  });
}

class MenuScreen extends StatelessWidget {
  final VoidCallback? onBackTap;
  final ValueChanged<String>? onMenuItemTap;

  const MenuScreen({
    super.key,
    this.onBackTap,
    this.onMenuItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<MenuItemData> menuItems = [
      MenuItemData(
        title: 'Notifications',
        icon: Icons.notifications_none_rounded,
        routeName: '/notifications',
      ),
      MenuItemData(
        title: 'Current Order',
        icon: Icons.chat_bubble_outline_rounded,
        routeName: '/current-order',
      ),
      MenuItemData(
        title: 'Send Order',
        icon: Icons.send_rounded,
        routeName: '/send-order',
      ),
      MenuItemData(
        title: 'Conform Order',
        icon: Icons.notifications_rounded,
        routeName: '/conform-order',
      ),
      MenuItemData(
        title: 'Calculator',
        icon: Icons.calculate_outlined,
        routeName: '/calculator',
      ),
      MenuItemData(
        title: 'Announcements',
        icon: Icons.campaign_rounded,
        routeName: '/announcements',
      ),
      MenuItemData(
        title: 'Settings',
        icon: Icons.settings_outlined,
        routeName: '/settings',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Menu',
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
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...menuItems.map((item) => _buildMenuItem(context, item)),
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

  Widget _buildMenuItem(BuildContext context, MenuItemData item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: InkWell(
        onTap: () {
          if (onMenuItemTap != null && item.routeName != null) {
            onMenuItemTap!(item.routeName!);
          } else if (item.routeName != null) {
            Navigator.pushNamed(context, item.routeName!);
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              // White Icon
              Icon(
                item.icon,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: 32),
              // Menu Label (Inter 700, 24px, #FFFFFF)
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.textWhite,
                    fontSize: 24,
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
