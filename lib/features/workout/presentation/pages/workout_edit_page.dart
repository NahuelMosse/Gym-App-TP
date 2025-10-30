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
    // TODO: Load the workout from the BLoC using widget.workoutId
    // For now, example values
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
              // TODO: Save changes
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name field
            TextField(
              controller: _nameController,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: InputDecoration(
                hintText: translations.workoutNameHint,
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            
            // Description field
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
            
            // Exercise list will go here in the future
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
