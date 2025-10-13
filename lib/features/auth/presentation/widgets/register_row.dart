import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prompt,
          style: theme.textTheme.bodyMedium,
        ),
        BlueTextButton(
          label: actionLabel,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
