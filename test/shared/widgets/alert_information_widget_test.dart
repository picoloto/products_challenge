import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/widgets/alert_information_widget.dart';

void main() {
  group('AlertInformationWidget', () {
    final String assetPathImage = 'assets/images/error.png';
    final String title = 'Something went wrong!';
    final Widget alertInformationWidget = MaterialApp(
      home: Scaffold(
        body: AlertInformationWidget(
          assetPathImage: assetPathImage,
          title: title,
        ),
      ),
    );

    testWidgets('Should display the image with the correct path',
        (WidgetTester tester) async {
      await tester.pumpWidget(alertInformationWidget);

      final finder = find.byType(Image);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Image;
      expect(widget.image, isInstanceOf<AssetImage>());
      expect((widget.image as AssetImage).assetName, assetPathImage);
    });

    testWidgets('Should display the title with the correct style',
        (WidgetTester tester) async {
      await tester.pumpWidget(alertInformationWidget);

      final finder = find.byType(Text);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Text;
      expect(widget.data, title);

      final textStyle = widget.style;
      expect(textStyle?.fontWeight, FontWeight.w600);
      expect(textStyle?.fontSize, 16);
      expect(textStyle?.color, AppColors.neutral65);
    });

    testWidgets('Should display the widget centered on the screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(alertInformationWidget);

      final finder = find.byType(Column);
      expect(finder, findsOneWidget);

      final widget = tester.widget(finder) as Column;
      expect(widget.mainAxisAlignment, MainAxisAlignment.center);
    });
  });
}
