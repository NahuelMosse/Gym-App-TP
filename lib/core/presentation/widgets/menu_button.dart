import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onPressed;

  final double width;
  final double height;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final double borderRadius;

  const MenuButton({
    super.key,
    required this.title,
    this.subtitle,
    required this.onPressed,
    this.width = 300,
    this.height = 120,
    this.backgroundColor = AppColors.button,
    this.titleColor = AppColors.textPrimary,
    this.subtitleColor = AppColors.textSecondary,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: TextStyle(color: subtitleColor, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
