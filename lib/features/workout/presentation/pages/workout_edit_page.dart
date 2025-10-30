import 'package:flutter/material.dart';
import '../../../internationalization/generated/translations.dart';

class WorkoutEditPage extends StatefulWidget {
  final String workoutId;

  const WorkoutEditPage({super.key, required this.workoutId});

  @override
  State<WorkoutEditPage> createState() => _WorkoutEditPageState();
}

class _WorkoutEditPageState extends State<WorkoutEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: Cargar el workout desde el BLoC usando widget.workoutId
    // Por ahora, valores de ejemplo
    _nameController.text = 'Workout Name';
    _descriptionController.text = '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.workoutEditTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO: Guardar cambios
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de nombre
            TextField(
              controller: _nameController,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: InputDecoration(
                hintText: translations.workoutNameHint,
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            
            // Campo de descripción
            TextField(
              controller: _descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: translations.workoutDescriptionHint,
                hintStyle: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
              ),
            ),
            
            const SizedBox(height: 24),
            const Divider(),
            
            // Aquí irá la lista de ejercicios en el futuro
            const Expanded(
              child: Center(
                child: Text('Exercise list will go here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
