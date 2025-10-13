import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double height;

  const GoogleSignInButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).extension<AppColors>()!.mutedBorder,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          elevation: 0,
        ),
        onPressed: onPressed,
        icon: Image.asset(
          'assets/google_logo.png',
          width: 20,
          height: 20,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.login, size: 20, color: Colors.white),
        ),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
