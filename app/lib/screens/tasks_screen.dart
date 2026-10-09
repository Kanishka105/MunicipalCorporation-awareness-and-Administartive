import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../models/user_model.dart';
import 'officer_tasks_screen.dart';
import 'field_worker_tasks_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final role = state.currentUser?.role ?? UserRole.citizen;

    if (role == UserRole.fieldOfficer) {
      return const FieldWorkerTasksScreen();
    } else {
      // Default to officer tasks for demo
      return const OfficerTasksScreen();
    }
  }
}
