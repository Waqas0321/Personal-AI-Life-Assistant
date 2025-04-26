import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../data/models/task_model.dart';
class ScheduleController extends GetxController {
  /// Task list
  var taskList = <TaskModel>[].obs;

  /// Calendar view type
  var calendarView = CalendarView.week.obs;

  /// Greeting
  var greeting = ''.obs;

  @override
  void onInit() {
    super.onInit();
    addDummyTasks();
    updateGreeting();
  }

  /// Change calendar view
  void changeView(CalendarView view) {
    calendarView.value = view;
  }

  /// Get list of Appointments from TaskModel
  List<Appointment> get calendarAppointments {
    return taskList.map((task) => Appointment(
      startTime: task.startTime,
      endTime: task.endTime,
      subject: task.title,
      color: getColorForCategory(task.category),
    )).toList();
  }

  /// Dummy task entries
  void addDummyTasks() {
    taskList.addAll([
      TaskModel(
        id: '1',
        title: 'Study Flutter',
        startTime: DateTime.now().add(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        category: 'academics',
      ),
      TaskModel(
        id: '2',
        title: 'Gym Workout',
        startTime: DateTime.now().add(const Duration(hours: 3)),
        endTime: DateTime.now().add(const Duration(hours: 4)),
        category: 'health',
      ),
      TaskModel(
        id: '3',
        title: 'Dinner with Friends',
        startTime: DateTime.now().add(const Duration(hours: 5)),
        endTime: DateTime.now().add(const Duration(hours: 6)),
        category: 'social',
      ),
    ]);
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
