import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/civic_app_state.dart';
import 'theme/app_theme.dart';
import 'widgets/top_header.dart';
import 'widgets/bottom_nav_bar.dart';
import 'screens/feed_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/copilot_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/executive_dashboard_screen.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CivicAppState()),
      ],
      child: const CivicPulseApp(),
    ),
  );
}

class CivicPulseApp extends StatelessWidget {
  const CivicPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();

    return MaterialApp(
      title: 'CivicPulse AI - Delhi Municipal Corporation',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: state.themeMode,
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();

    if (!state.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: CivicColors.primary),
        ),
      );
    }

    if (!state.isAuthenticated) {
      return const LoginScreen();
    }

    return Scaffold(
      appBar: const TopHeader(),
      body: IndexedStack(
        index: state.currentNavIndex,
        children: const [
          FeedScreen(),
          TasksScreen(),
          CopilotScreen(),
          AnalyticsScreen(),
          ExecutiveDashboardScreen(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
