import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'blue_text_button.dart';

class RegisterRow extends StatelessWidget {
  final String prompt;
  final String actionLabel;
  final VoidCallback? onPressed;

  const RegisterRow({
    super.key,
    required this.prompt,
    required this.actionLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4,
      children: [
        Text(
          prompt,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        BlueTextButton(
          label: actionLabel,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
