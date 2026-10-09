import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/report_screen.dart';
import 'screens/grievance_detail_screen.dart';
import 'screens/field_worker_tasks_screen.dart';
import 'screens/task_completion_screen.dart';

void main() {
  runApp(const CleanCityApp());
}

class CleanCityApp extends StatelessWidget {
  const CleanCityApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanCity',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainScreen(),
        '/report': (context) => const ReportScreen(),
        '/grievance_detail': (context) => const GrievanceDetailScreen(),
        '/field_worker_tasks': (context) => const FieldWorkerTasksScreen(),
        '/task_completion': (context) => const TaskCompletionScreen(),
      },
    );
  }
}
