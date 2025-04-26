import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/faetures/bottom_nav/controller/bottomNav_controller.dart';
import 'package:personal_ai_life_assistant/faetures/reminder/controller/reminder_controller.dart';
import 'package:personal_ai_life_assistant/faetures/summeries/controller/summeries_controller.dart';
import 'package:personal_ai_life_assistant/faetures/task/tasks_list/controller/tasks_list_controller.dart';
import '../../faetures/auth/forget_password/controller/forget_password_controller.dart';
import '../../faetures/auth/sign_up/controller/signup_controller.dart';
import '../../faetures/auth/signin/controller/signIn_controller.dart';
import '../../faetures/profile/controller/profile_controller.dart';
import '../../faetures/schedule/controllers/schedule_controller.dart';
import '../../faetures/splash/controllers/splash_controller.dart';
import '../../faetures/task/add_tasks/controller/task_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.lazyPut(() => SplashController());

    Get.put(ForgetPasswordController());
    Get.lazyPut(() => ForgetPasswordController());

    Get.put(SignUpController());
    Get.lazyPut(() => SignUpController());

    Get.put(SignInController());
    Get.lazyPut(() => SignInController());

    Get.put(ScheduleController());
    Get.lazyPut(() => ScheduleController());

    Get.put(ReminderController());
    Get.lazyPut(() => ReminderController());

    Get.put(SummariesController());
    Get.lazyPut(() => SummariesController());

    Get.put(TaskController());
    Get.lazyPut(() => TaskController());

    Get.put(TasksListController());
    Get.lazyPut(() => TasksListController());

    Get.put(BottomNavController());
    Get.lazyPut(() => BottomNavController());

    Get.put(ProfileController());
    Get.lazyPut(() => ProfileController());
  }
  }

