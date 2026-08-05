import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/splash/presentation/pages/splash_page.dart';
import 'package:mall_companion_staff/features/splash/presentation/widgets/responsive_splash_layout.dart';

void main() {
  testWidgets('SplashPage renders ResponsiveSplashLayout', (WidgetTester tester) async {
    // Build the SplashPage inside a MaterialApp
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashPage(),
      ),
    );

    // Verify that the page structure and responsive layout are present
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.byType(ResponsiveSplashLayout), findsOneWidget);

    // Advance fake time to complete all delayed tasks inside SplashBloc
    await tester.pump(const Duration(seconds: 4));
  });
}
