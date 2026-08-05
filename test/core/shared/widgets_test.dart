import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_section_header.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_info_card.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_stat_card.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_status_chip.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_gradient_button.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_icon_button.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_avatar.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_badge.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:mall_companion_staff/core/shared/presentation/widgets/app_error_state.dart';

void main() {
  group('Shared UI Library Widgets', () {
    testWidgets('AppSectionHeader renders title and trailing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Test Title',
              trailing: Text('Trailing'),
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Trailing'), findsOneWidget);
    });

    testWidgets('AppInfoCard renders child and padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppInfoCard(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('AppStatCard renders values and labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppStatCard(
              icon: Icons.star,
              value: '100',
              label: 'Stars',
              color: Colors.amber,
              bgColor: Colors.yellow,
            ),
          ),
        ),
      );

      expect(find.text('100'), findsOneWidget);
      expect(find.text('STARS'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('AppStatusChip renders labels and active pulse', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppStatusChip(
              label: 'OPEN',
              textColor: Colors.green,
              backgroundColor: Colors.lightGreen,
              pulsingDotColor: Colors.greenAccent,
            ),
          ),
        ),
      );

      expect(find.text('OPEN'), findsOneWidget);
    });

    testWidgets('AppGradientButton handles tap actions', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppGradientButton(
              onTap: () => tapped = true,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });

    testWidgets('AppIconButton handles tap actions', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.add,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      expect(tapped, isTrue);
    });

    testWidgets('AppAvatar renders network image placeholders', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppAvatar(
              imageUrl: '',
            ),
          ),
        ),
      );

      expect(find.byType(AppAvatar), findsOneWidget);
    });

    testWidgets('AppBadge overlays numeric details', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBadge(
              label: '5',
              child: Text('Inbox'),
            ),
          ),
        ),
      );

      expect(find.text('Inbox'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('AppLoadingIndicator renders spinner', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoadingIndicator(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('AppErrorState renders messages and triggers onRetry', (WidgetTester tester) async {
      bool retried = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorState(
              title: 'Server Error',
              message: 'Check connection details.',
              onRetry: () => retried = true,
            ),
          ),
        ),
      );

      expect(find.text('Server Error'), findsOneWidget);
      expect(find.text('Check connection details.'), findsOneWidget);

      await tester.tap(find.text('Try Again'));
      expect(retried, isTrue);
    });
  });
}
