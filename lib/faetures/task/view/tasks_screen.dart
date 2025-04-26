import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/const/app_colors.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_appbar.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_elevated_button.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_input_textfield.dart';
import '../../../core/widgets/custom_toast_show.dart';
import '../controller/task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({Key? key}) : super(key: key);

  final TaskController taskController = Get.put(TaskController());
  final ToastClass toast = ToastClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
              vertical: constraints.maxHeight * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputTextField(
                  hintText: 'Enter task title',
                  labelText: 'Title',
                  textEditingController: taskController.titleController,
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                CustomInputTextField(
                  hintText: 'Enter task description',
                  labelText: 'Description',
                  textEditingController: taskController.descriptionController,
                  maxLines: 5,
                ),
                SizedBox(height: constraints.maxHeight * 0.04),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Save Task',
                    onPress: () {
                      if (taskController.titleController.text.isEmpty ||
                          taskController.descriptionController.text.isEmpty) {
                        toast.showCustomToast('Please fill all fields!');
                        return;
                      }
                      taskController.saveTask();
                      toast.showCustomToast('Task Saved Successfully!');
                      taskController.clearFields();
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