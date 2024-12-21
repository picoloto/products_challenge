import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/image_test/image_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/image_network_widget.dart';
import 'package:products_challenge/shared/widgets/product_tile_widget.dart';
import 'package:products_challenge/shared/widgets/rate_widget.dart';

import '../../mocks/product_mock.dart';

void main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    GetItLocator.setup();
  });

  group('ProductTileWidget', () {
    final product = ProductMock.product1;

    final Widget simpleProductTileWithoutFavoriteWidget = MaterialApp(
      home: Scaffold(
        body: ProductTileWidget(product: product),
      ),
    );

    final Widget productTileWidgetWithFavoriteWidget = MaterialApp(
      home: Scaffold(
        body: ProductTileWidget(
          product: product,
          favoriteWidget: Icon(Icons.favorite),
        ),
      ),
    );

    testWidgets('Should display the correct product image',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(simpleProductTileWithoutFavoriteWidget);

        final finder = find.byType(ImageNetworkWidget);
        expect(finder, findsOneWidget);

        final widget = tester.widget(finder) as ImageNetworkWidget;
        expect(widget.imageUrl, product.image);
      });
    });

    testWidgets('Should display the product title correctly',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ProductTileWidget(product: product),
            ),
          ),
        );

        final finder = find.text(product.title);
        expect(finder, findsOneWidget);
      });
    });

    testWidgets('Should display the review correctly',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ProductTileWidget(product: product),
            ),
          ),
        );

        final finder = find.byType(RateWidget);
        expect(finder, findsOneWidget);

        final widget = tester.widget(finder) as RateWidget;
        expect(widget.rate, product.rating.rate);
        expect(widget.reviewCount, product.rating.count);
      });
    });

    testWidgets('Should display product price correctly',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ProductTileWidget(product: product),
            ),
          ),
        );

        final finder = find.text('\$${product.price.toStringAsFixed(2)}');
        expect(finder, findsOneWidget);
      });
    });

    testWidgets('Should display favoriteWidget widget if passed',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(productTileWidgetWithFavoriteWidget);

        final finder = find.byIcon(Icons.favorite);
        expect(finder, findsOneWidget);
      });
    });

    testWidgets('Should not display favoriteWidget widget if not passed',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(simpleProductTileWithoutFavoriteWidget);

        final favoriteFinder = find.byIcon(Icons.favorite);
        expect(favoriteFinder, findsNothing);
      });
    });

    testWidgets('Should display the layout with the correct spacing',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(simpleProductTileWithoutFavoriteWidget);

        final paddingFinder = find.byType(Padding);
        expect(paddingFinder, findsOneWidget);
      });
    });
  });
}
