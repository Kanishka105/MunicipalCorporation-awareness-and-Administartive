import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/hazard_model.dart';
import '../models/officer_task_model.dart';
import '../models/copilot_model.dart';

class CivicStorageService {
  static const String _keyUser = 'civic_current_user';
  static const String _keyThemeMode = 'civic_theme_mode';
  static const String _keyActiveSubmission = 'civic_active_submission';
  static const String _keyHazards = 'civic_hazards_list';
  static const String _keyUrgentTask = 'civic_urgent_task';
  static const String _keyCompletedTasks = 'civic_completed_tasks';
  static const String _keyHotspots = 'civic_hotspots';

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  Future<UserModel?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyUser);
    if (data != null) {
      try {
        return UserModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
      } catch (_) {}
    }
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }

  Future<void> saveThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyThemeMode, isDark);
  }

  Future<bool?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyThemeMode);
  }

  Future<void> saveActiveSubmission(ActiveSubmissionModel sub) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyActiveSubmission, jsonEncode(sub.toJson()));
  }

  Future<ActiveSubmissionModel?> loadActiveSubmission() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyActiveSubmission);
    if (data != null) {
      try {
        return ActiveSubmissionModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
      } catch (_) {}
    }
    return null;
  }

  Future<void> saveHazards(List<HazardRadarModel> hazards) async {
    final prefs = await SharedPreferences.getInstance();
    final list = hazards.map((e) => e.toJson()).toList();
    await prefs.setString(_keyHazards, jsonEncode(list));
  }

  Future<List<HazardRadarModel>?> loadHazards() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyHazards);
    if (data != null) {
      try {
        final list = jsonDecode(data) as List<dynamic>;
        return list.map((e) => HazardRadarModel.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {}
    }
    return null;
  }

  Future<void> saveUrgentTask(UrgentOfficerTaskModel task) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUrgentTask, jsonEncode(task.toJson()));
  }

  Future<UrgentOfficerTaskModel?> loadUrgentTask() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyUrgentTask);
    if (data != null) {
      try {
        return UrgentOfficerTaskModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
      } catch (_) {}
    }
    return null;
  }

  Future<void> saveCompletedTasks(List<CompletedTaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final list = tasks.map((e) => e.toJson()).toList();
    await prefs.setString(_keyCompletedTasks, jsonEncode(list));
  }

  Future<List<CompletedTaskModel>?> loadCompletedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyCompletedTasks);
    if (data != null) {
      try {
        final list = jsonDecode(data) as List<dynamic>;
        return list.map((e) => CompletedTaskModel.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {}
    }
    return null;
  }

  Future<void> saveHotspots(List<HotspotLedgerItemModel> hotspots) async {
    final prefs = await SharedPreferences.getInstance();
    final list = hotspots.map((e) => e.toJson()).toList();
    await prefs.setString(_keyHotspots, jsonEncode(list));
  }

  Future<List<HotspotLedgerItemModel>?> loadHotspots() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyHotspots);
    if (data != null) {
      try {
        final list = jsonDecode(data) as List<dynamic>;
        return list.map((e) => HotspotLedgerItemModel.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {}
    }
    return null;
  }
}
