import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../controller/bottomNav_controller.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final BottomNavController navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => navController.screens[navController.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.blackish,
          backgroundColor: AppColors.white,
          selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          elevation: 2,
          currentIndex: navController.currentIndex.value,
          onTap: (index) {
            navController.currentIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Obx(
                () => Image.asset(
                  AppImages.home,
                  color:
                      navController.currentIndex.value == 1
                          ? AppColors.primary
                          : AppColors.blackish,
                  height: 24,
                  width: 24,
                ),
              ),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Obx(
                () => Image.asset(
                  AppImages.home,
                  color:
                      navController.currentIndex.value == 2
                          ? AppColors.primary
                          : AppColors.blackish,
                  height: 24,
                  width: 24,
                ),
              ),
              label: 'Mood',
            ),
            BottomNavigationBarItem(
              icon: Obx(
                () => Image.asset(
                  AppImages.home,
                  color:
                      navController.currentIndex.value == 3
                          ? AppColors.primary
                          : AppColors.blackish,
                  height: 24,
                  width: 24,
                ),
              ),
              label: 'Reminders',
            ),
            BottomNavigationBarItem(
              icon: Obx(
                () => Image.asset(
                  AppImages.home,
                  color:
                      navController.currentIndex.value == 4
                          ? AppColors.primary
                          : AppColors.blackish,
                  height: 24,
                  width: 24,
                ),
              ),
              label: 'summaries',
            ),
          ],
        ),
      ),
    );
  }
}
