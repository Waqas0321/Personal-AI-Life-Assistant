import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/faetures/bottom_nav/controller/bottomNav_controller.dart';
import '../../faetures/auth/forget_password/controller/forget_password_controller.dart';
import '../../faetures/auth/sign_up/controller/signup_controller.dart';
import '../../faetures/auth/signin/controller/signIn_controller.dart';
import '../../faetures/schedule/controllers/schedule_controller.dart';
import '../../faetures/splash/controllers/splash_controller.dart';
class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.lazyPut(
      () => SplashController(),
    );

    Get.put(ForgetPasswordController());
    Get.lazyPut(
          () => ForgetPasswordController(),
    );

    Get.put(SignUpController());
    Get.lazyPut(
      () => SignUpController(),
    );

    Get.put(SignInController());
    Get.lazyPut(() => SignInController());

    Get.put(ScheduleController());
    Get.lazyPut(() => ScheduleController());

    Get.put(BottomNavController());
    Get.lazyPut(() => BottomNavController());



  }
}
