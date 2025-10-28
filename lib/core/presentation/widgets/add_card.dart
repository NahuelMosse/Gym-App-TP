import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'detail_card.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
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
