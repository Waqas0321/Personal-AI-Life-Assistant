import 'package:flutter/animation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:personal_ai_life_assistant/core/app_routes/routes.dart';
import 'package:personal_ai_life_assistant/faetures/bottom_nav/view/bottom_nav_screen.dart';
import 'package:personal_ai_life_assistant/faetures/check_list/view/check_list_screen.dart';
import 'package:personal_ai_life_assistant/faetures/task/add_tasks/view/task_screen.dart';
import '../../faetures/auth/forget_password/view/forget_password_screen.dart';
import '../../faetures/auth/sign_up/view/sign_up_screen.dart';
import '../../faetures/auth/signin/view/signin_screen.dart';
import '../../faetures/schedule/view/schedule_screen.dart';
import '../../faetures/splash/view/splash_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: AppRoutes.SPLASHSCREEN,
        page: () => SplashScreen(),
        transition: Transition.fade,
        curve: Curves.linear,
        transitionDuration: const Duration(microseconds: 200)),
    GetPage(
        name: AppRoutes.SIGNINSCREEN,
        page: () => SignInScreen(),
        transition: Transition.fade,
        curve: Curves.linear,
        transitionDuration: const Duration(microseconds: 200)),
    GetPage(
        name: AppRoutes.SIGNUPSCREEN,
        page: () => SignUpScreen(),
        transition: Transition.zoom,
        transitionDuration: const Duration(microseconds: 300)),
    GetPage(
        name: AppRoutes.FORGETPASSWORDSCREEN,
        page: () => ForgetPasswordScreen(),
        transition: Transition.fade,
        curve: Curves.linear,
        transitionDuration: const Duration(microseconds: 200)),
    GetPage(
        name: AppRoutes.BOTTOMNAVSCREEN,
        page: () => BottomNavScreen(),
        transition: Transition.fade,
        curve: Curves.linear,
        transitionDuration: const Duration(microseconds: 200)),
    GetPage(
        name: AppRoutes.HOMESCREEN,
        page: () => ScheduleScreen(),
        transition: Transition.fade,
        curve: Curves.linear,
        transitionDuration: const Duration(microseconds: 200)),
    GetPage(
        name: AppRoutes.ADDTASKSCREEN,
        page: () => TaskScreen(),
        transition: Transition.fade,
        curve: Curves.linear,
        transitionDuration: const Duration(microseconds: 200)),
    GetPage(
        name: AppRoutes.CHECKLISTSCREEN,
        page: () => ChecklistScreen(),
        transition: Transition.fade,
        curve: Curves.linear,
        transitionDuration: const Duration(microseconds: 200)),

  ];
}
