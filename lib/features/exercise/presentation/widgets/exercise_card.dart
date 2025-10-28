import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/detail_card.dart';
import '../../domain/entities/exercise.dart';
import 'muscle_chip.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback? onTap;

  const ExerciseCard({super.key, required this.exercise, this.onTap});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      onTap: onTap,
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
    );
  }
}
