import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/faetures/reminder/view/reminder_screen.dart';
import 'package:personal_ai_life_assistant/faetures/summeries/view/summeries_screen.dart';
import 'package:personal_ai_life_assistant/faetures/task/tasks_list/view/task_list_screen.dart';
import '../../schedule/view/schedule_screen.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  final screens = [
    ScheduleScreen(),
    TaskListScreen(),
    ReminderScreen(),
    SummariesScreen(),
  ];
}

