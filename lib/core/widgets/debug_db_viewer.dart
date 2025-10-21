import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'db_viewer.dart';

class DebugDbViewer extends StatelessWidget {
  const DebugDbViewer({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: const Icon(Icons.bug_report),
      tooltip: 'View Database',
      color: Colors.orange,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DbViewer(),
          ),
        );
      },
    );
  }
}
