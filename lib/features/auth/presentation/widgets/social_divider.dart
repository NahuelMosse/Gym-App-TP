import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SocialDivider extends StatelessWidget {
  final String label;

  const SocialDivider({
    super.key,
    this.label = 'or',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.mutedBorder, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(label, style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          )),
        ),
        Expanded(child: Divider(color: AppColors.mutedBorder, thickness: 1)),
      ],
    );
  }
}
