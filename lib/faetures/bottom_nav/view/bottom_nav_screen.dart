import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import 'package:personal_ai_life_assistant/faetures/task/add_tasks/view/task_screen.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
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
          Get.to(TaskScreen());
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Keeps it fixed at the bottom
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

class BottomNavItem extends StatelessWidget {
  final int index;
  final String iconPath;
  final String label;
  final RxInt currentIndex;
  final Color selectedColor;
  final Color unselectedColor;

  const BottomNavItem({
    Key? key,
    required this.index,
    required this.iconPath,
    required this.label,
    required this.currentIndex,
    required this.selectedColor,
    required this.unselectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        currentIndex.value = index;
      },
      child: Obx(() {
        final isSelected = currentIndex.value == index;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
              height: 24,
              width: 24,
            ),
            const SizedBox(height: 6),
            CustomTextWidget(
              text: label,
              fontSize: 11,
              textColor:
                  isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            ),
          ],
        );
      }),
    );
  }
}
