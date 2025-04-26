import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_ai_life_assistant/core/utils/app_sizes.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_appbar.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_elevated_button.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/widgets/custom_input_textfield.dart';
import '../controller/task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TaskController controller = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Add Task"),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                  GestureDetector(
                    onTap: () {
                      controller.startListening();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.mic, color: Colors.white),
                        onPressed: () {
                          // your mic logic here
                        },
                      ),
                    ),
                  )
                ],
              ),
             Gap(12),
              CustomTextWidget(
                text: 'Start Time',
              ),
             Gap(3),
              InkWell(
                onTap: () => controller.pickDateTime(context, true),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.whitish,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: AppColors.blackish),
                  ),
                  child: Obx(
                        () => Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(controller.startTime.value),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
             Gap(12),

              CustomTextWidget(
                text: 'End Time',
              ),
              Gap(3),
              InkWell(
                onTap: () => controller.pickDateTime(context, false),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.whitish,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: AppColors.blackish),
                  ),
                  child: Obx(
                        () => Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(controller.endTime.value),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
             Gap(12),

              CustomTextWidget(
                text: 'Category',
              ),
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
                    items: controller.categoryList.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Gap(AppSizes().getHeightPercentage(10)),
              CustomElevatedButton(
                onPress: controller.addTask,
                text: "Add Task",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
