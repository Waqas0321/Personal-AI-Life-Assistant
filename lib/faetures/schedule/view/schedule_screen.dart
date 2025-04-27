import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_ai_life_assistant/core/Const/app_colors.dart';
import 'package:personal_ai_life_assistant/core/app_routes/routes.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../core/Const/app_images.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../profile/view/profile_screen.dart';
import '../controllers/schedule_controller.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key});

  ScheduleController controller = Get.find();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(
            title: controller.greeting.value ?? "Dashboard",
            actionsWidgets: [
              GestureDetector(
                onTap: () {
                  Get.to(() => ProfileScreen());
                },
                child: StreamBuilder(
                  stream: controller.getUserStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(AppImages.logo),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      final user = snapshot.data;

                      return CircleAvatar(
                        radius: 18,
                        backgroundImage:
                            user!.imagePath != null
                                ? NetworkImage(user.imagePath!)
                                : AssetImage(AppImages.logo) as ImageProvider,
                      );
                    } else {
                      return CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(AppImages.logo),
                      );
                    }
                  },
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Day') {
                    controller.changeView(CalendarView.day);
                  } else if (value == 'Week') {
                    controller.changeView(CalendarView.week);
                  } else if (value == 'Month') {
                    controller.changeView(CalendarView.month);
                  } else if (value == 'CheckList Show') {
                    Get.toNamed(AppRoutes.CHECKLISTSCREEN);
                  }
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: 'CheckList Show',
                        child: CustomTextWidget(text: 'CheckList Show'),
                      ),
                      const PopupMenuItem(
                        value: 'Day',
                        child: CustomTextWidget(text: 'Day View'),
                      ),
                      const PopupMenuItem(
                        value: 'Week',
                        child: CustomTextWidget(text: 'Week View'),
                      ),
                      const PopupMenuItem(
                        value: 'Month',
                        child: CustomTextWidget(text: 'Month View'),
                      ),
                    ],
              ),
              Gap(12),
            ],
          ),
          body: Column(
            children: [
              Gap(6),
              Container(
                padding: appSizes.getCustomPadding(),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackish,
                      spreadRadius: -1,
                      blurRadius: 8,
                    ),
                  ],
                ),
                width: appSizes.getWidthPercentage(90),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.moods.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final mood = controller.moods[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.selectMood(mood['label']);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedMood.value != mood['label']
                                      ? Colors.grey[200]
                                      : AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    controller.selectedMood.value ==
                                            mood['label']
                                        ? AppColors.primary
                                        : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextWidget(
                                    text: mood['emoji'],
                                    fontSize: 40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Gap(8),
              Expanded(
                child: Obx(
                  () => SfCalendar(
                    backgroundColor: AppColors.white,
                    view: controller.calendarView.value,
                    dataSource: TaskDataSource(
                      controller.taskList
                          .map(
                            (task) => Appointment(
                              startTime: task.startTime,
                              endTime: task.endTime,
                              subject: task.taskTitle,
                              color: controller.getColorForCategory(
                                task.category,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    allowDragAndDrop: true,
                    onDragEnd: (AppointmentDragEndDetails details) {
                      final Appointment? oldAppointment =
                          details.appointment as Appointment?;
                      final DateTime? newStart = details.droppingTime;
                      if (oldAppointment != null && newStart != null) {
                        final Appointment newAppointment = Appointment(
                          startTime: newStart,
                          endTime: newStart.add(
                            oldAppointment.endTime.difference(
                              oldAppointment.startTime,
                            ),
                          ),
                          subject: oldAppointment.subject,
                          color: oldAppointment.color,
                        );
                        // update task here if needed
                      }
                    },
                    onTap: (CalendarTapDetails details) {
                      if (details.appointments != null &&
                          details.appointments!.isNotEmpty) {
                        final Appointment tappedAppointment =
                            details.appointments!.first;

                        /// Show a simple dialog or tooltip
                        final DateFormat formatter = DateFormat(
                          'MMM dd, yyyy – hh:mm a',
                        );
                        Get.defaultDialog(
                          backgroundColor: AppColors.white,
                          titlePadding: EdgeInsets.zero,
                          title: '',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextWidget(
                                text: tappedAppointment.subject,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                              Gap(12),
                              CustomTextWidget(
                                text:
                                    "🕑 Start: ${formatter.format(tappedAppointment.startTime)}",
                              ),
                              const SizedBox(height: 8),
                              CustomTextWidget(
                                text:
                                    "🕑 End: ${formatter.format(tappedAppointment.endTime)}",
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Custom DataSource for the Calendar
class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}
