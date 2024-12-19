import 'dart:async';
import 'dart:ui';

class Debouncer {
  Timer? _timer;
  final int milliseconds;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
