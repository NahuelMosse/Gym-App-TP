import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SignInWithButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double height;
  final String logo;

  const SignInWithButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height = 48,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: AppColors.mutedBorder,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: Image.asset(
                  logo,
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.login, 
                    size: 20, 
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary, 
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
