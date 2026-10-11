import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Widget? titleWidget;
  final bool? centerTitle;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? leading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;
  final bool isDashboard;
  final VoidCallback? onProfileTap;
  final VoidCallback? onMenuTap;

  const AppHeader({
    super.key,
    this.title,
    this.subtitle,
    this.titleWidget,
    this.centerTitle,
    this.showBack = true,
    this.onBack,
    this.leading,
    this.actions,
    this.backgroundColor = AppColors.background,
    this.elevation = 0,
    this.isDashboard = false,
    this.onProfileTap,
    this.onMenuTap,
  });

  factory AppHeader.dashboard({
    String? title,
    VoidCallback? onProfileTap,
    VoidCallback? onMenuTap,
    Color backgroundColor = AppColors.background,
  }) {
    return AppHeader(
      title: title,
      isDashboard: true,
      showBack: false,
      onProfileTap: onProfileTap,
      onMenuTap: onMenuTap,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isDashboard) {
      return Container(
        color: backgroundColor,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Yellow Profile Icon (Figma: #F5B800)
                GestureDetector(
                  onTap: onProfileTap,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFF5B800), width: 3),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFFF5B800),
                      size: 28,
                    ),
                  ),
                ),

                // Optional Title (e.g., Business Home)
                if (title != null) ...[
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.textWhite,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ] else
                  const Spacer(),

                // Yellow Hamburger Menu Icon (Figma: #F5B800)
                GestureDetector(
                  onTap: onMenuTap,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.menu_rounded,
                      color: Color(0xFFF5B800),
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final bool isCentered = centerTitle ?? (subtitle == null);

    Widget? effectiveTitle;
    if (titleWidget != null) {
      effectiveTitle = titleWidget;
    } else if (title != null) {
      if (subtitle != null) {
        effectiveTitle = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: AppColors.textWhite,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      } else {
        effectiveTitle = Text(
          title!,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: AppColors.textWhite,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        );
      }
    }

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: isCentered,
      leading: leading ??
          (showBack
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFFF5B800),
                    size: 20,
                  ),
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                )
              : null),
      title: effectiveTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
