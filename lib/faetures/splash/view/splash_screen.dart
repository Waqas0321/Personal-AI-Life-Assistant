import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.find<SplashController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: AppColors.white,
          child: Center(
            child: Image.asset(
              AppImages.logo,
              height: 200,
              width: 200,
            ),
          ),
        );
      },
    );
  }
}
