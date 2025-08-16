import 'dart:async';

class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 220)});
  final Duration delay;
  Timer? _timer;

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
