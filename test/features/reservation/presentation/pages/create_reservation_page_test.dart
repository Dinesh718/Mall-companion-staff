import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mall_companion_staff/features/reservation/presentation/pages/create_reservation_page.dart';

void main() {
  testWidgets('CreateReservationPage renders all steps and bottom bar', (WidgetTester tester) async {
    // Because it contains a Scaffold, wrap in a MaterialApp
    await tester.pumpWidget(const MaterialApp(
      home: CreateReservationPage(),
    ));

    // Verify Title
    expect(find.text('Create Reservation'), findsWidgets);

    // Verify Steps
    expect(find.text('CUSTOMER DETAILS'), findsOneWidget);
    expect(find.text('CHOOSE SCHEDULE'), findsOneWidget);
    
    // Scroll down to see the rest of the steps
    await tester.drag(find.byType(SingleChildScrollView).first, const Offset(0, -1000));
    await tester.pump();
    
    expect(find.text('CONFIGURE PARTY'), findsOneWidget);
    expect(find.text('ADD PREFERENCES'), findsOneWidget);

    // Verify Bottom Bar
    expect(find.text('Create Reservation'), findsWidgets); // one in appbar and one in bottom bar
    expect(find.text('Save Draft'), findsOneWidget);
  });
}
