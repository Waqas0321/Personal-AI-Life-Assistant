import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/faetures/task/view/task_screen.dart';
import '../../mood/view/mood_screen.dart';
import '../../schedule/view/schedule_screen.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  final screens = [
    ScheduleScreen(),
    TaskScreen(),
    MoodScreen (),
    ScheduleScreen(),
    ScheduleScreen(),
  ];
}
