import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/widgets/separator_widget.dart';

void main() {
  group('SeparatorWidget', () {
    Widget getWidget() => MaterialApp(
          home: Scaffold(
            body: SeparatorWidget(),
          ),
        );

    testWidgets('Should display the divider with the correct style',
        (WidgetTester tester) async {
      await tester.pumpWidget(getWidget());

      final finder = find.byType(Divider);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Divider;
      expect(widget.color, AppColors.neutralLight);
    });
  });
}
