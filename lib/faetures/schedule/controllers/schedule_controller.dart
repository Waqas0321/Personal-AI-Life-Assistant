import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../data/models/task_model.dart';
import '../../../data/providers/local_database/database_helper.dart';
import '../../../data/providers/local_database/databse_constants.dart';
import '../../../data/shared_preference/shared_preference_services.dart';

class ScheduleController extends GetxController {
  var selectedMood = ''.obs;

  void selectMood(String mood) async {
    selectedMood.value = mood;
    await getTasksByUserId();
  }

  final List<Map<String, dynamic>> moods = [
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😢', 'label': 'Sad'},
    {'emoji': '😡', 'label': 'Angry'},
    {'emoji': '😴', 'label': 'Tired'},
  ];

  /// Task list
  RxList<TaskModel> taskList = <TaskModel>[].obs;

  /// Calendar view type
  var calendarView = CalendarView.week.obs;

  /// Greeting
  var greeting = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    getCurrentTag();
    await getTasksByUserId();
    updateGreeting();
  }

  /// Change calendar view
  void changeView(CalendarView view) {
    calendarView.value = view;
  }

  /// Get list of Appointments from TaskModel
  List<Appointment> get calendarAppointments {
    return taskList
        .map(
          (task) => Appointment(
            startTime: task.startTime,
            endTime: task.endTime,
            subject: task.taskTitle,
            color: getColorForCategory(task.category),
          ),
        )
        .toList();
  }

  /// Dummy task entries
  Future<void> getTasksByUserId() async {
    try {
      String? userId = await PreferenceHelper.getString("userID");
      if (userId == null) {
        taskList.clear();
        return;
      }

      List<Map<String, dynamic>> categoryMapList = await DatabaseHelper()
          .getListById(
            DatabaseConstants.tasksTable,
            DatabaseConstants.columnUserId,
            userId,
          );

      List<TaskModel> tasks =
          categoryMapList.map((map) => TaskModel.fromMap(map)).toList();
      String selectedMood = this.selectedMood.value.trim();

      if (selectedMood.isNotEmpty) {
        tasks = filterTasksByMood(tasks, selectedMood);
      }

      taskList.value = tasks;
    } catch (e) {
      log('Error fetching tasks by user ID: $e');
      taskList.clear();
    }
  }

  /// Separate mood filtering logic into a helper function
  List<TaskModel> filterTasksByMood(List<TaskModel> tasks, String mood) {
    switch (mood) {
      case 'Angry':
        return tasks
            .where((task) => task.category != 'Academic Schedule')
            .toList();
      case 'Sad':
        return tasks.where((task) => task.category != 'Social').toList();
      case 'Tired':
        return [];
      case 'Happy':
        return tasks.where((task) => task.category != '').toList();
      default:
        return tasks;
    }
  }

  /// Category → Color mapping
  Color getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'academics':
        return Colors.blue;
      case 'health':
        return Colors.green;
      case 'social':
        return Colors.orange;
      case 'personal':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  /// Dynamic greeting based on time
  void updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      greeting.value = 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      greeting.value = 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      greeting.value = 'Good Evening';
    } else {
      greeting.value = 'Good Night';
    }
  }
}
