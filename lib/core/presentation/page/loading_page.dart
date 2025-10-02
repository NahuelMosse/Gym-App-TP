import 'package:flutter/material.dart';

/// Widget de loading reutilizable para estados de carga
class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
    this.message = 'Cargando...',
  });

  /// Mensaje personalizable para el loading
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}