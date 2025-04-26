import 'package:get/get.dart';
import '../../../core/app_routes/routes.dart';
import '../../../data/shared_preference/shared_preference_services.dart';
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToSignIn();
  }

  void navigateToSignIn() async {
    String? userId = await PreferenceHelper.getString("userID");
    Future.delayed(const Duration(seconds: 3), () {
      if (userId == null || userId.isEmpty) {
        Get.offAllNamed(AppRoutes.SIGNINSCREEN);
      } else {
        Get.offAllNamed(AppRoutes.BOTTOMNAVSCREEN);
      }
    });
  }
}
