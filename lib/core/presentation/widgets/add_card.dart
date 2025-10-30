import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'detail_card.dart';

class AddCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      onTap: onTap,
      child: Center(
        child: Icon(
          Icons.add,
          size: 48,
          color: AppColors.disabled,
        ),
      ),
    );
  }
}
