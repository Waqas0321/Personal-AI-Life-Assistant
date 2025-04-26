import 'package:get/get.dart';
import '../../schedule/view/schedule_screen.dart';
class BottomNavController extends GetxController {

  var currentIndex = 0.obs;
  final screens = [
     ScheduleScreen(),
     ScheduleScreen(),
     ScheduleScreen(),
     ScheduleScreen(),
  ];
}