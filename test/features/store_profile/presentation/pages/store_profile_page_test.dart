import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/pages/store_profile_page.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/widgets/store_profile_header.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/widgets/store_identity_card.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/widgets/statistics_section.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/widgets/location_card.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/widgets/operational_status_card.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/widgets/weekly_schedule_card.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/widgets/social_media_card.dart';
import 'package:mall_companion_staff/features/store_profile/presentation/widgets/gallery_card.dart';

void main() {
  testWidgets('StoreProfilePage loads data and renders all widgets successfully',
      (WidgetTester tester) async {
    // 1. Set larger screen size to avoid scroll view clipping issues
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(800 * dpi, 2000 * dpi);
    addTearDown(() {
      tester.view.resetPhysicalSize();
    });

    // 2. Render Page
    await tester.pumpWidget(
      const MaterialApp(
        home: StoreProfilePage(),
      ),
    );

    // Verify loading indicator is shown initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 3. Complete mock repository latency delay
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    // 4. Verify all components are rendered correctly
    expect(find.byType(StoreProfileHeader), findsOneWidget);
    expect(find.byType(StoreIdentityCard), findsOneWidget);
    expect(find.byType(StatisticsSection), findsOneWidget);
    expect(find.byType(LocationCard), findsOneWidget);
    expect(find.byType(OperationalStatusCard), findsOneWidget);
    expect(find.byType(WeeklyScheduleCard), findsOneWidget);
    expect(find.byType(SocialMediaCard), findsOneWidget);
    expect(find.byType(GalleryCard), findsOneWidget);

    // Verify texts
    expect(find.text('Nike Flagship Store'), findsOneWidget);
    expect(find.text('John David (Manager)'), findsOneWidget);
    expect(find.text('Mall Navigation'), findsOneWidget);
    expect(find.text('Real-time Pulse'), findsOneWidget);
    expect(find.text('Store Hours'), findsOneWidget);
    expect(find.text('Connect & Social'), findsOneWidget);
    expect(find.text('Store Gallery'), findsOneWidget);
  });
}
