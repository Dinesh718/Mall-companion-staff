import 'package:flutter/material.dart';
import 'core/themes/app_theme.dart';
import 'features/splash/presentation/pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StaffMallApp());
}

class StaffMallApp extends StatelessWidget {
  const StaffMallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mall Companion Staff',
      theme: AppTheme.lightTheme,
      home: const SplashPage(),
    );
  }
}
