import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/utils/app_sizes.dart';
import 'package:personal_ai_life_assistant/faetures/reminder/controller/reminder_controller.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/widgets/custom_text_widget.dart';
class ReminderScreen extends StatelessWidget {
 ReminderScreen({super.key});
final ReminderController controller = Get.find();
final AppSizes appSizes = AppSizes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(child: CustomTextWidget(text: "Summeries")),
    );
  }
}
