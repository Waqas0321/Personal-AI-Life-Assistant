import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/app_routes/routes.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_bottom_nav_item.dart';
import '../controller/bottomNav_controller.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final BottomNavController navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => navController.screens[navController.currentIndex.value]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        onPressed: () {
          Get.toNamed(AppRoutes.ADDTASKSCREEN, arguments: {'taskModel': null});
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Keeps it fixed at the bottom
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BottomNavItem(
                    index: 0,
                    iconPath: AppImages.schedule,
                    label: 'Schedule',
                    currentIndex: navController.currentIndex,
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white70,
                  ),
                  Gap(22),
                  BottomNavItem(
                    index: 1,
                    iconPath: AppImages.tasks,
                    label: 'Task',
                    currentIndex: navController.currentIndex,
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white70,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavItem(
                    index: 2,
                    iconPath: AppImages.reminder,
                    label: 'Reminders',
                    currentIndex: navController.currentIndex,
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white70,
                  ),
                  Gap(6),
                  BottomNavItem(
                    index: 3,
                    iconPath: AppImages.summeries,
                    label: 'Summaries',
                    currentIndex: navController.currentIndex,
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white70,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
