import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/Const/app_colors.dart';
import 'package:personal_ai_life_assistant/core/utils/app_sizes.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_appbar.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import '../controller/check_list_controller.dart';

class ChecklistScreen extends StatelessWidget {
  final ChecklistController controller = Get.find();

  ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Check List", goBack: true),
      body: Padding(
        padding: AppSizes().getCustomPadding(),
        child: Column(
          children: [
            DropdownButton<String>(
              value:
                  controller.goalInput.value.isEmpty
                      ? null
                      : controller.goalInput.value,
              hint: CustomTextWidget(text: 'Select Goal'),
              isExpanded: true,
              onChanged: (value) {
                if (value != null) {
                  controller.goalInput.value = value;
                  controller.generateChecklist();
                }
              },
              items:
                  controller.checklistTemplates.keys
                      .map(
                        (goal) => DropdownMenuItem<String>(
                          value: goal,
                          child: CustomTextWidget(text: goal),
                        ),
                      )
                      .toList(),
            ),
            Gap(30),
            Obx(() {
              return controller.isLoading.value
                  ? Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                  : Expanded(
                    child: ListView.builder(
                      itemCount: controller.checklistTasks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Expanded(
                                child: CustomTextWidget(
                                  text: controller.checklistTasks[index],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
            }),
          ],
        ),
      ),
    );
  }
}
