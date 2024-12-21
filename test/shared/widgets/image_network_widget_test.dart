import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/image_test/image_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/shared/widgets/image_network_widget.dart';

import '../../mocks/product_mock.dart';

void main() {
  group('ImageNetworkWidget', () {
    final String imageUrl = ProductMock.product1.image;
    final double width = 126;
    final double height = 126;

    final Widget imageNetworkWidget = MaterialApp(
      home: Scaffold(
        body: ImageNetworkWidget(
          imageUrl: imageUrl,
          width: width,
          height: height,
        ),
      ),
    );

    testWidgets('Should display the correct product image',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(imageNetworkWidget);

        final finder = find.byType(ImageNetworkWidget);
        expect(finder, findsOneWidget);

        final widget = tester.widget(finder) as ImageNetworkWidget;
        expect(widget.imageUrl, imageUrl);
      });
    });

    testWidgets('Should display the sized box with correct size',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(imageNetworkWidget);

        final finder = find.byType(SizedBox);
        expect(finder, findsOneWidget);

        final widget = tester.widget(finder) as SizedBox;
        expect(widget.width, width);
        expect(widget.height, height);
      });
    });
  });
}
