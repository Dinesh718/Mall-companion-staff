import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/main.dart';
import 'package:mall_companion_staff/features/splash/presentation/pages/splash_page.dart';

void main() {
  testWidgets('StaffMallApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StaffMallApp());

    // Verify that SplashPage is rendered as home
    expect(find.byType(SplashPage), findsOneWidget);

    // Advance fake time to complete all delayed tasks inside SplashBloc
    await tester.pump(const Duration(seconds: 4));
  });
}
