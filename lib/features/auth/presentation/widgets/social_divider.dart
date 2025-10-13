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
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>();
    final color = appColors?.mutedBorder;
    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: color
    );

    return Row(
      children: [
        Expanded(child: Divider(color: color, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(label, style: textStyle),
        ),
        Expanded(child: Divider(color: color, thickness: 1)),
      ],
    );
  }
}
