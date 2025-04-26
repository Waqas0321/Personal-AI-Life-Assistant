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