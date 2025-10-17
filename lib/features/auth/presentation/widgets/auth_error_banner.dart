import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AuthErrorBanner extends StatelessWidget {
  final String message;

  const AuthErrorBanner({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.errorBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.errorText,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.errorText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
