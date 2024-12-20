import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/shared/utils/debouncer.dart';

void main() {
  group('Debouncer', () {
    test('call should call action after 500 ms', () async {
      bool inAction = false;
      final debouncer = Debouncer(milliseconds: 500);

      debouncer(() {
        inAction = true;
      });

      expect(inAction, isFalse);

      await Future.delayed(Duration(milliseconds: 500));

      expect(inAction, isTrue);
    });

    test('call should call the action only once', () async {
      int callCount = 0;

      final debouncer = Debouncer(milliseconds: 300);

      debouncer(() {
        callCount++;
      });
      debouncer(() {
        callCount++;
      });
      debouncer(() {
        callCount++;
      });

      await Future.delayed(Duration(milliseconds: 350));

      expect(callCount, 1);
    });
  });
}
