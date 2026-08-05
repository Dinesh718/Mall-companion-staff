import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/pages/store_manager_dashboard_page.dart';
import 'package:mall_companion_staff/core/presentation/widgets/dashboard_greeting.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/widgets/store_hero_card.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/widgets/business_health_card.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/widgets/quick_actions_grid.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/widgets/live_queue_card.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/widgets/offers_carousel.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/widgets/reservation_list.dart';
import 'package:mall_companion_staff/features/dashboard/presentation/widgets/bottom_navigation.dart';

void main() {
  testWidgets('StoreManagerDashboardPage loads data and renders all dashboard components',
      (WidgetTester tester) async {
    // 1. Set larger screen size to avoid scroll view clipping issues
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(800 * dpi, 1600 * dpi);
    addTearDown(() {
      tester.view.resetPhysicalSize();
    });

    // 2. Render Page
    await tester.pumpWidget(
      const MaterialApp(
        home: StoreManagerDashboardPage(),
      ),
    );

    // Verify loading indicator is shown initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 3. Complete mock repository latency delay
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    // 4. Verify all components are rendered correctly
    expect(find.byType(DashboardGreeting), findsOneWidget);
    expect(find.byType(StoreHeroCard), findsOneWidget);
    expect(find.byType(BusinessHealthCard), findsOneWidget);
    expect(find.byType(QuickActionsGrid), findsOneWidget);
    expect(find.byType(LiveQueueCard), findsOneWidget);
    expect(find.byType(OffersCarousel), findsOneWidget);
    expect(find.byType(ReservationList), findsOneWidget);
    expect(find.byType(BottomNavigation), findsOneWidget);

    // Verify texts
    expect(find.text('John David'), findsOneWidget);
    expect(find.text('Nike Flagship Store'), findsOneWidget);
    expect(find.text('CSAT SCORE'), findsOneWidget);
    expect(find.text('Live Queue'), findsOneWidget);
    expect(find.text("Today's Offers"), findsOneWidget);
  });
}
