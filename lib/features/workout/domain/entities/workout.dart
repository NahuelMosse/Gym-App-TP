class Workout {
  final String id;
  final String name;
  final String description;
  final String userId;
  final DateTime updatedAt;
  final DateTime createdAt;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
  });
}

