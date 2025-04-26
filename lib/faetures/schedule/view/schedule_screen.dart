import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../core/utils/app_sizes.dart';
import '../controllers/schedule_controller.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key});

  ScheduleController controller = Get.find();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Daily Planner'),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Day') {
                    controller.changeView(CalendarView.day);
                  } else if (value == 'Week') {
                    controller.changeView(CalendarView.week);
                  } else if (value == 'Month') {
                    controller.changeView(CalendarView.month);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'Day', child: Text('Day View')),
                  const PopupMenuItem(value: 'Week', child: Text('Week View')),
                  const PopupMenuItem(value: 'Month', child: Text('Month View')),
                ],
              ),
            ],
          ),
            body: Obx(
                  () => SfCalendar(
                view: controller.calendarView.value,
                dataSource: TaskDataSource(controller.tasks),
                allowDragAndDrop: true,
                onDragEnd: (AppointmentDragEndDetails details) {
                  final Appointment? oldAppointment = details.appointment as Appointment?;
                  final DateTime? newStart = details.droppingTime;

                  if (oldAppointment != null && newStart != null) {
                    final Appointment newAppointment = Appointment(
                      startTime: newStart,
                      endTime: newStart.add(
                        oldAppointment.endTime.difference(oldAppointment.startTime),
                      ),
                      subject: oldAppointment.subject,
                      color: oldAppointment.color,
                      notes: oldAppointment.notes,
                      location: oldAppointment.location,
                      isAllDay: oldAppointment.isAllDay,
                      resourceIds: oldAppointment.resourceIds,
                      recurrenceRule: oldAppointment.recurrenceRule,
                    );
                    controller.updateTask(oldAppointment, newAppointment);
                  }
                },
              ),
            )

        );
      },
    );
  }
}
// Custom DataSource for the Calendar
class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}
