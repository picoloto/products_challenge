import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/widgets/icon_text_widget.dart';

import '../../mocks/product_mock.dart';

void main() {
  group('IconTextWidget', () {
    final IconData icon = Icons.sort;
    final String text = ProductMock.product1.category;
    final Widget iconTextWidget = MaterialApp(
      home: Scaffold(
        body: IconTextWidget(
          icon: icon,
          text: text,
        ),
      ),
    );

    testWidgets('Should display the icon with the iconData',
        (WidgetTester tester) async {
      await tester.pumpWidget(iconTextWidget);

      final finder = find.byType(Icon);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Icon;
      expect(widget.icon, isInstanceOf<IconData>());
      expect((widget.icon as IconData), icon);
    });

    testWidgets('Should display the icon with the correct style',
        (WidgetTester tester) async {
      await tester.pumpWidget(iconTextWidget);

      final finder = find.byType(Icon);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Icon;
      expect(widget.size, 24);
      expect(widget.color, AppColors.neutralDark);
    });

    testWidgets('Should display the text with the correct style',
        (WidgetTester tester) async {
      await tester.pumpWidget(iconTextWidget);

      final finder = find.byType(Text);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Text;
      expect(widget.data, text);

      final textStyle = widget.style;
      expect(textStyle?.fontWeight, FontWeight.w500);
      expect(textStyle?.fontSize, 16);
      expect(textStyle?.color, AppColors.neutralDark);
    });
  });
}
