import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/authentication/presentation/pages/authentication_page.dart';
import 'package:mall_companion_staff/features/authentication/presentation/widgets/role_selector.dart';
import 'package:mall_companion_staff/features/authentication/presentation/widgets/mobile_input_field.dart';

void main() {
  testWidgets('AuthenticationPage renders login title, role tabs, input field and action button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AuthenticationPage(),
      ),
    );

    // Verify Welcome Staff header is present
    expect(find.text('Welcome Staff'), findsOneWidget);

    // Verify custom role selector pill row renders
    expect(find.byType(RoleSelector), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
    expect(find.text('Security'), findsOneWidget);
    expect(find.text('Maint.'), findsOneWidget);
    expect(find.text('Store'), findsOneWidget);

    // Verify Mobile input card is present
    expect(find.byType(MobileInputField), findsOneWidget);
    expect(find.text('+91'), findsOneWidget);

    // Verify continue button renders
    expect(find.text('Continue'), findsOneWidget);
  });
}
