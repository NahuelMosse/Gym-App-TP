import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class BlueTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  const BlueTextButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 0, vertical: 4)),
        minimumSize: WidgetStateProperty.all(const Size(0, 0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryBright;
          }
          return AppColors.primary;
        }),
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
