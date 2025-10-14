import 'dart:async';
import 'package:flutter/foundation.dart';

/// It triggers a notification redirect when the stream emits.
class NotifyOnRefreshStream extends ChangeNotifier {
  NotifyOnRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
