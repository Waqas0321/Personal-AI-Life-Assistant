import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_ai_life_assistant/core/utils/app_sizes.dart';
import 'package:personal_ai_life_assistant/faetures/reminder/controller/reminder_controller.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_text_widget.dart';
import '../../../data/models/task_model.dart';

class ReminderScreen extends StatelessWidget {
  ReminderScreen({super.key});

  final ReminderController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: CustomAppBar(title: "Reminders"),
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (controller.tasksList.isEmpty) {
          return Center(
            child: CustomTextWidget(
              text: "Reminders not found!",
              fontSize: 14,
              textColor: AppColors.primary,
            ),
          );
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Gap(6),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.tasksList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      TaskModel task = controller.tasksList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackish,
                                blurRadius: 6,
                                spreadRadius: -1,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppImages.tasks,
                                height: 28,
                                color: AppColors.primary,
                              ),
                              Gap(6),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidget(
                                    text: task.taskTitle,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CustomTextWidget(
                                    text: task.category,
                                    fontSize: 12,
                                    textColor: AppColors.blackish,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Row(
                                    children: [
                                      CustomTextWidget(
                                        text: DateFormat(
                                          'dd MMM yyyy',
                                        ).format(task.startTime),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      Gap(6),
                                      SizedBox(
                                        width: 10,
                                        child: Divider(
                                          thickness: 1,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Gap(6),
                                      CustomTextWidget(
                                        text: DateFormat(
                                          'dd MMM yyyy',
                                        ).format(task.endTime),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gap(8);
                    },
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
