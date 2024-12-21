import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/route/routes.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/alert_information_widget.dart';
import 'package:products_challenge/view/error/error_view.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../../mocks/go_router_mock.dart';

void main() {
  group('ErrorView', () {
    Widget getWidget() => MaterialApp(
          home: ErrorView(),
        );

    Widget getProductsRouterWidget() => MaterialApp.router(
          routerConfig: GoRouterMock.getRouter(
            getWidget(),
            Text('Products View'),
            Routes.productsView,
          ),
        );

    setUpAll(() {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      GetItLocator.setup();
    });

    testWidgets('Should display alert widget with image and title',
        (tester) async {
      await tester.pumpWidget(getWidget());

      expect(find.byType(AlertInformationWidget), findsOneWidget);
      expect(find.text('Something went wrong!'), findsOneWidget);
      expect(find.byWidgetPredicate((widget) {
        return widget is AlertInformationWidget &&
            widget.assetPathImage == 'assets/images/error.png';
      }), findsOneWidget);
    });

    testWidgets('Should "Go Home" button navigates to the products screen',
        (tester) async {
      await tester.pumpWidget(getProductsRouterWidget());

      final goHomeButton = find.text('Go Home');
      expect(goHomeButton, findsOneWidget);

      await tester.tap(goHomeButton);
      await tester.pumpAndSettle();

      expect(find.text('Products View'), findsOneWidget);
    });
  });
}
