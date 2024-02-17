import 'dart:async';

import 'package:flutter/rendering.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  int get tick => _timer?.tick ?? 0;

  run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  dispose() {
    if (_timer?.isActive ?? false) _timer!.cancel();
  }
}
