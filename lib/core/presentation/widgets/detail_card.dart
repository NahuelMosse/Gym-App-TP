import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class DetailCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const DetailCard({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final card = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppColors.disabled, width: 2),
      ),
      child: Container(
        height: 170,
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: card,
      );
    }

    return card;
  }
}
