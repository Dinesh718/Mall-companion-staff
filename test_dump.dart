
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/reservation/presentation/pages/reservation_details_page.dart';

void main() {
  testWidgets('Dump ReservationDetailsPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ReservationDetailsPage(reservationId: 'RES-001')));
    await tester.pumpAndSettle();
    debugDumpApp();
  });
}

