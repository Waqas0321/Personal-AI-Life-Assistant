import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_appbar.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_elevated_button.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/widgets/custom_input_textfield.dart';
import '../controller/task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TaskController controller = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Task",),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputTextField(
                hintText: 'Enter task title',
                labelText: 'Title',
                textEditingController: controller.titleController,
              ),
              const SizedBox(height: 20),

              Text(
                'Start Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: () =>controller.pickDateTime(context, true),
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
              const SizedBox(height: 20),

              Text(
                'End Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
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
              const SizedBox(height: 20),

              Text(
                'Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
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
              Gap(40),
              CustomElevatedButton(onPress: controller.addTask, text: "Add Task")
            ],
          ),
        ),
      ),
    );
  }
}
