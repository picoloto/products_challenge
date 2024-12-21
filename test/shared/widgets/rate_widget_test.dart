import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/widgets/rate_widget.dart';

import '../../mocks/rating_mock.dart';

void main() {
  group('RateWidget', () {
    final double rate = RatingMock.rating1.rate;
    final int reviewCount = RatingMock.rating1.count;

    final Widget iconTextWidget = MaterialApp(
      home: Scaffold(
        body: RateWidget(
          rate: rate,
          reviewCount: reviewCount,
        ),
      ),
    );

    testWidgets('Should display the icon with the Icons.star',
        (WidgetTester tester) async {
      await tester.pumpWidget(iconTextWidget);

      final finder = find.byType(Icon);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Icon;
      expect(widget.icon, isInstanceOf<IconData>());
      expect((widget.icon as IconData), Icons.star);
    });

    testWidgets('Should display the icon with the correct style',
        (WidgetTester tester) async {
      await tester.pumpWidget(iconTextWidget);

      final finder = find.byType(Icon);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Icon;
      expect(widget.size, 22);
      expect(widget.color, AppColors.attentionLighter);
    });

    testWidgets('Should display the text with the correct style',
        (WidgetTester tester) async {
      await tester.pumpWidget(iconTextWidget);

      final finder = find.byType(Text);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Text;
      expect(widget.data, '3.9 (120 reviews)');

      final textStyle = widget.style;
      expect(textStyle?.fontWeight, FontWeight.w600);
      expect(textStyle?.fontSize, 14);
      expect(textStyle?.color, AppColors.neutral65);
    });
  });
}
