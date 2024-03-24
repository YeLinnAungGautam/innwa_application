import "dart:async";

import "package:flutter/material.dart";

class Debouncer {
  Debouncer({required this.milliseconds});
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
