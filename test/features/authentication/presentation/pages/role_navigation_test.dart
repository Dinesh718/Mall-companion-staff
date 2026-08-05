import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/authentication/presentation/pages/authentication_page.dart';
import 'package:mall_companion_staff/features/authentication/presentation/widgets/role_selector.dart';
import 'package:mall_companion_staff/features/authentication/presentation/widgets/mobile_input_field.dart';
import 'package:mall_companion_staff/features/authentication/presentation/widgets/otp_input_row.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/pages/admin_dashboard_page.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/pages/security_dashboard_page.dart';

void main() {
  testWidgets('Admin role login navigates to AdminDashboardPage',
      (WidgetTester tester) async {
    // 1. Set larger screen size to prevent viewport overflow issues
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(800 * dpi, 1200 * dpi);
    addTearDown(() {
      tester.view.resetPhysicalSize();
    });

    // 2. Render App Home (AuthenticationPage)
    await tester.pumpWidget(
      const MaterialApp(
        home: AuthenticationPage(),
      ),
    );

    // Verify we are on AuthenticationPage
    expect(find.byType(RoleSelector), findsOneWidget);
    expect(find.byType(MobileInputField), findsOneWidget);

    // 3. Select Admin role
    await tester.tap(find.text('Admin'));
    await tester.pumpAndSettle();

    // 4. Enter Phone Number for Admin (9876543211)
    await tester.enterText(find.byType(TextField), '9876543211');
    await tester.pumpAndSettle();

    // 5. Tap Continue to dispatch SendOtpRequested
    final continueBtn = find.text('Continue');
    await tester.ensureVisible(continueBtn);
    await tester.tap(continueBtn);
    await tester.pump(); // Start async action
    await tester.pump(const Duration(milliseconds: 900)); // Complete latency delay
    await tester.pumpAndSettle(); // Settle navigation transition

    // 6. Verify we are on OtpVerificationPage
    expect(find.byType(OtpInputRow), findsOneWidget);

    // 7. Enter OTP code 123456
    final otpFields = find.descendant(
      of: find.byType(OtpInputRow),
      matching: find.byType(TextField),
    );
    expect(otpFields, findsNWidgets(6));
    
    await tester.enterText(otpFields.at(0), '1');
    await tester.enterText(otpFields.at(1), '2');
    await tester.enterText(otpFields.at(2), '3');
    await tester.enterText(otpFields.at(3), '4');
    await tester.enterText(otpFields.at(4), '5');
    await tester.enterText(otpFields.at(5), '6');
    await tester.pump(); // Start verifyOtp execution
    await tester.pump(const Duration(milliseconds: 900)); // Complete latency delay
    await tester.pumpAndSettle(); // Settle route transition

    // 8. Verify we have landed on AdminDashboardPage
    expect(find.byType(AdminDashboardPage), findsOneWidget);
    expect(find.text('Welcome, Admin User!'), findsOneWidget);
  });

  testWidgets('Security role login navigates to SecurityDashboardPage',
      (WidgetTester tester) async {
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(800 * dpi, 1200 * dpi);
    addTearDown(() {
      tester.view.resetPhysicalSize();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: AuthenticationPage(),
      ),
    );

    // 1. Select Security role
    await tester.tap(find.text('Security'));
    await tester.pumpAndSettle();

    // 2. Enter Phone Number for Security (9876543210)
    await tester.enterText(find.byType(TextField), '9876543210');
    await tester.pumpAndSettle();

    // 3. Tap Continue
    final continueBtn = find.text('Continue');
    await tester.ensureVisible(continueBtn);
    await tester.tap(continueBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();

    // 4. Verify we are on OtpVerificationPage
    expect(find.byType(OtpInputRow), findsOneWidget);

    // 5. Enter OTP code 123456
    final otpFields = find.descendant(
      of: find.byType(OtpInputRow),
      matching: find.byType(TextField),
    );
    await tester.enterText(otpFields.at(0), '1');
    await tester.enterText(otpFields.at(1), '2');
    await tester.enterText(otpFields.at(2), '3');
    await tester.enterText(otpFields.at(3), '4');
    await tester.enterText(otpFields.at(4), '5');
    await tester.enterText(otpFields.at(5), '6');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();

    // 6. Verify we have landed on SecurityDashboardPage
    expect(find.byType(SecurityDashboardPage), findsOneWidget);
    expect(find.text('Welcome, Security Team!'), findsOneWidget);
  });

  testWidgets('New user (9876543214) navigates to CompleteProfilePage first',
      (WidgetTester tester) async {
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(800 * dpi, 1200 * dpi);
    addTearDown(() {
      tester.view.resetPhysicalSize();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: AuthenticationPage(),
      ),
    );

    // 1. Select Maint. role
    await tester.tap(find.text('Maint.'));
    await tester.pumpAndSettle();

    // 2. Enter Phone Number for New User (9876543214)
    await tester.enterText(find.byType(TextField), '9876543214');
    await tester.pumpAndSettle();

    // 3. Tap Continue
    final continueBtn = find.text('Continue');
    await tester.ensureVisible(continueBtn);
    await tester.tap(continueBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();

    // 4. Verify we are on OtpVerificationPage
    expect(find.byType(OtpInputRow), findsOneWidget);

    // 5. Enter OTP code 123456
    final otpFields = find.descendant(
      of: find.byType(OtpInputRow),
      matching: find.byType(TextField),
    );
    await tester.enterText(otpFields.at(0), '1');
    await tester.enterText(otpFields.at(1), '2');
    await tester.enterText(otpFields.at(2), '3');
    await tester.enterText(otpFields.at(3), '4');
    await tester.enterText(otpFields.at(4), '5');
    await tester.enterText(otpFields.at(5), '6');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();

    // 6. Verify we have landed on CompleteProfilePage
    expect(find.text('Complete Your Profile'), findsOneWidget);

    // 7. Tap Complete Profile and verify it routes to MaintenanceDashboardPage
    await tester.tap(find.text('Complete Profile & Go to Dashboard'));
    await tester.pumpAndSettle();
    expect(find.text('Good Morning, Alex'), findsOneWidget);
  });
}
