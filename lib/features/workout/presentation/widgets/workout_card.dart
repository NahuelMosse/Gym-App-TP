import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/widgets/detail_card.dart';
import '../../../../core/router/creator_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../internationalization/generated/translations.dart';
import '../../domain/entities/workout.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    
    return DetailCard(
      onTap: () {
        context.push(CreatorRoutes.workoutEditPath(workout.id));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              workout.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (workout.description != null && workout.description!.isNotEmpty)
              Text(
                workout.description!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                translations.view,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
