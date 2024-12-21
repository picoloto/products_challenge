import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';

void main() {
  group('LoadingWidget', () {
    final Widget loadingWidget = MaterialApp(
      home: Scaffold(
        body: LoadingWidget(),
      ),
    );

    testWidgets('Should display the widget centered on the screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(loadingWidget);

      final finder = find.byType(Center);
      expect(finder, findsOneWidget);
    });

    testWidgets('Should display a circular progress indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(loadingWidget);

      final finder = find.byType(CircularProgressIndicator);
      expect(finder, findsOneWidget);
    });
  });
}
