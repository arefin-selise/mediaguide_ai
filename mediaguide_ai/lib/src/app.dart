import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/root_nav.dart';
import 'services/deep_link_service.dart';
import 'screens/dashboard_screen.dart';
import 'screens/symptom_checker_screen.dart';
import 'screens/medicine_scanner_screen.dart';
import 'screens/coach_screen.dart';
import 'screens/reports_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class MediGuideApp extends ConsumerWidget {
  const MediGuideApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'MediGuide AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      navigatorKey: rootNavigatorKey,
      routes: {
        '/': (context) => const RootNav(),
        '/dashboard': (context) => const DashboardScreen(),
        '/symptoms': (context) => const SymptomCheckerScreen(),
        '/scan': (context) => const MedicineScannerScreen(),
        '/coach': (context) => const CoachScreen(),
        '/reports': (context) => const ReportsScreen(),
      },
      home: DeepLinkBootstrap(navKey: rootNavigatorKey, child: const RootNav()),
    );
  }
}
