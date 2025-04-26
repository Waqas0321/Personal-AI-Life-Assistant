import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_ai_life_assistant/core/Const/app_images.dart';
import 'package:personal_ai_life_assistant/core/utils/app_sizes.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_appbar.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_elevated_button.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import 'package:personal_ai_life_assistant/data/models/task_model.dart';
import '../../../../core/Const/app_colors.dart';
import '../../../../core/widgets/custom_input_textfield.dart';
import '../controller/task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final TaskModel? taskModel = Get.arguments['taskModel'];
    if (taskModel != null) {
      controller.titleController.text = taskModel.taskTitle;
      controller.startTime.value = taskModel.startTime;
      controller.endTime.value = taskModel.endTime;
      controller.selectedCategory.value = taskModel.category;
    } else {
      controller.titleController.clear();
      controller.startTime.value = DateTime.now();
      controller.endTime.value = DateTime.now();
      controller.selectedCategory.value = 'Academics';
    }
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Add Task", goBack: true),
      body: Padding(
        padding: AppSizes().getCustomPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomInputTextField(
                    hintText: 'Enter task title',
                    labelText: 'Title',
                    textEditingController: controller.titleController,
                  ),
                ),
                Gap(12),
                Obx(
                  () => GestureDetector(
                    onLongPressStart: (_) {
                      controller.startListening();
                    },
                    onLongPressEnd: (_) {
                      controller.stopListening();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            controller.isListening.value
                                ? Colors.red
                                : AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (controller.isListening.value)
                            BoxShadow(
                              color: Colors.redAccent.withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          controller.isListening.value
                              ? Icons.mic
                              : Icons.mic_none,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(8),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 200,
                width: AppSizes().getWidthPercentage(100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.blackish, width: 1),
                ),
              ),
            ),
            Gap(12),
            CustomTextWidget(text: 'Start Time'),
            Gap(3),
            InkWell(
              onTap: () => controller.pickDateTime(context, true),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whitish,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: AppColors.blackish),
                ),
                child: Obx(
                  () => Text(
                    DateFormat(
                      'yyyy-MM-dd HH:mm',
                    ).format(controller.startTime.value),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            Gap(12),
            CustomTextWidget(text: 'End Time'),
            Gap(3),
            InkWell(
              onTap: () => controller.pickDateTime(context, false),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whitish,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: AppColors.blackish),
                ),
                child: Obx(
                  () => Text(
                    DateFormat(
                      'yyyy-MM-dd HH:mm',
                    ).format(controller.endTime.value),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            Gap(12),
            CustomTextWidget(text: 'Category'),
            Gap(3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.whitish,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColors.blackish),
              ),
              child: Obx(
                () => DropdownButton<String>(
                  value: controller.selectedCategory.value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  onChanged: (value) {
                    if (value != null) controller.setCategory(value);
                  },
                  items:
                      controller.categoryList.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                ),
              ),
            ),
            Spacer(),
            Obx(
              () => CustomElevatedButton(
                isLoading: controller.isLoading.value,
                onPress: () {
                  if (taskModel != null) {
                    controller.updateTask(taskModel.taskId!);
                  } else {
                    controller.addTask();
                  }
                },
                text: taskModel != null ? "Update Task" : "Add Task",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
