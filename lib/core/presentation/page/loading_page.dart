import 'package:flutter/material.dart';

/// Reusable loading widget for loading states
class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
    this.message = 'Loading...',
  });

  /// Customizable message for the loading screen
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}