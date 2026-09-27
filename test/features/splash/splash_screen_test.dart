import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:LJF_admin/core/constants/asset_paths.dart';
import 'package:LJF_admin/core/routing/routes.dart';
import 'package:LJF_admin/core/widgets/other/image_helper.dart';
import 'package:LJF_admin/features/splash/view/screen/splash_screen.dart';

void main() {
  Widget buildTestableWidget({
    Duration splashDuration = const Duration(milliseconds: 500),
    NavigatorObserver? observer,
  }) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        navigatorObservers: observer != null ? [observer] : [],
        routes: {
          Routes.splash: (_) => SplashScreen(splashDuration: splashDuration),
          Routes.courses: (_) => const Scaffold(body: Text('Courses Screen')),
        },
        initialRoute: Routes.splash,
      ),
    );
  }

  testWidgets('SplashScreen displays Thaheen logo and progress indicator', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(splashDuration: const Duration(seconds: 10)),
    );

    // Initial pump
    await tester.pump();

    // Verify ImageHelper with thaheenLogo is present
    final imageHelperFinder = find.byWidgetPredicate(
      (widget) => widget is ImageHelper && widget.image == AssetPaths.thaheenLogo,
    );
    expect(imageHelperFinder, findsOneWidget);

    // Verify progress indicator is present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Pump animation forward
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));

    // Cancel pending timer by pumping beyond or tearing down
    await tester.pumpAndSettle(const Duration(seconds: 11));
  });

  testWidgets('SplashScreen navigates to courses screen after splashDuration', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(splashDuration: const Duration(milliseconds: 400)),
    );

    // Let animation run and timer fire
    await tester.pump();
    expect(find.text('Courses Screen'), findsNothing);

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('Courses Screen'), findsOneWidget);
  });
}
