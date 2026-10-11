import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final double height;
  final double borderRadius;
  final Color backgroundColor;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.height = 44.0,
    this.borderRadius = 17.0,
    this.backgroundColor = AppColors.primaryYellow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above field
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: AppColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Pill input container matching Figma
        Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            children: [
              // Left icon badge if icon is present
              if (icon != null) ...[
                Container(
                  width: 44,
                  height: height,
                  decoration: BoxDecoration(
                    color: AppColors.iconBadgeBg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: icon,
                ),
                const SizedBox(width: 14),
              ] else
                const SizedBox(width: 18),

              // Input text field
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword,
                  keyboardType: keyboardType,
                  cursorColor: AppColors.textBlack,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.textBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 11),
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.textBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
            ],
          ),
        ),
      ],
    );
  }
}
