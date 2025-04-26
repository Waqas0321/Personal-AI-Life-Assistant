import 'dart:ui';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class ScheduleController extends GetxController {
  /// List of tasks
  var tasks = <Appointment>[].obs;

  /// Current view (Day/Week/Month)
  var calendarView = CalendarView.week.obs;

  @override
  void onInit() {
    super.onInit();
    tasks.add(
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
        subject: 'Example Task',
        color: const Color(0xFF0F8644),
      ),
    );
  }

  void changeView(CalendarView view) {
    calendarView.value = view;
  }

  void updateTask(Appointment oldTask, Appointment newTask) {
    tasks.remove(oldTask);
    tasks.add(newTask);
  }
}
