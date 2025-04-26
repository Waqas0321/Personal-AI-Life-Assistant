import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/const/app_colors.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../controller/mood_controller.dart';

class MoodScreen extends StatelessWidget {
  MoodScreen({Key? key}) : super(key: key);

  final MoodController controller = Get.put(MoodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'How are you feeling today?',
        backgroundColor: AppColors.primary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
              vertical: constraints.maxHeight * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: constraints.maxWidth * 0.05,
                  runSpacing: constraints.maxHeight * 0.02,
                  children: controller.moods.map((mood) {
                    return Obx(
                          () => GestureDetector(
                        onTap: () {
                          controller.selectMood(mood['label']);
                        },
                        child: Container(
                          width: constraints.maxWidth * 0.18,
                          height: constraints.maxWidth * 0.18,
                          decoration: BoxDecoration(
                            color: controller.selectedMood.value == mood['label']
                                ? AppColors.primary
                                : Colors.grey[300],
                            shape: BoxShape.circle,
                            boxShadow: controller.selectedMood.value == mood['label']
                                ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              mood['emoji'],
                              style: TextStyle(
                                fontSize: constraints.maxWidth * 0.08,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Save Mood',
                    onPress: () {
                      if (controller.selectedMood.isEmpty) {
                        controller.toast.showCustomToast('Please select your mood first!');
                        return;
                      }
                      controller.saveMood();
                      controller.toast.showCustomToast('Mood Saved Successfully!');
                      controller.clear();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}