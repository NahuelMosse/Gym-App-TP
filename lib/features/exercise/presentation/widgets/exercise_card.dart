import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/exercise.dart';
import 'muscle_chip.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppColors.disabled, width: 2),
      ),
      child: Container(
        height: 170,
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    exercise.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(
                  exercise.public ? Icons.public : Icons.lock,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),

            Text(
              exercise.description,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),

            const Spacer(),

            Wrap(
              spacing: 8,
              runSpacing: 6,
              alignment: WrapAlignment.end,
              verticalDirection: VerticalDirection.up,
              children:
                  exercise.exerciseMuscles
                      ?.map(
                        (exerciseMuscle) =>
                            MuscleChip(muscle: exerciseMuscle.muscle!),
                      )
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}
