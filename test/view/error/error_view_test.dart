import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/alert_information_widget.dart';
import 'package:products_challenge/view/error/error_view.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  group('ErrorView', () {
    final Widget errorView = MaterialApp(
      home: ErrorView(),
    );

    setUpAll(() {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      GetItLocator.setup();
    });

    testWidgets('Should display alert widget with image and title',
        (tester) async {
      await tester.pumpWidget(errorView);

      expect(find.byType(AlertInformationWidget), findsOneWidget);
      expect(find.text('Something went wrong!'), findsOneWidget);
      expect(find.byWidgetPredicate((widget) {
        return widget is AlertInformationWidget &&
            widget.assetPathImage == 'assets/images/error.png';
      }), findsOneWidget);
    });

    testWidgets('Should "Go Home" button navigates to the products screen',
        (tester) async {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const ErrorView(),
          ),
          GoRoute(
            path: Routes.productsView,
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: Text('Products')),
              body: Center(child: Text('Products View')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      final goHomeButton = find.text('Go Home');
      expect(goHomeButton, findsOneWidget);

      await tester.tap(goHomeButton);
      await tester.pumpAndSettle();

      expect(find.text('Products View'), findsOneWidget);
    });
  });
}
