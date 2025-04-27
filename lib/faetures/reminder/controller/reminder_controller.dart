import 'dart:async';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/widgets/custom_toast_show.dart';
import '../../../data/models/task_model.dart';
import '../../../data/providers/local_database/database_helper.dart';
import '../../../data/providers/local_database/databse_constants.dart';
import '../../../data/shared_preference/shared_preference_services.dart';

class ReminderController extends GetxController {
  ToastClass toast = ToastClass();
  RxList<TaskModel> tasksList = <TaskModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getTasksByUserId();
    startNotificationScheduler();
  }

  Future<void> getTasksByUserId() async {
    try {
      String? userId = await PreferenceHelper.getString("userID");
      if (userId == null) {
        tasksList.clear();
        return;
      }
      List<Map<String, dynamic>> categoryMapList = await DatabaseHelper()
          .getListById(
            DatabaseConstants.tasksTable,
            DatabaseConstants.columnUserId,
            userId,
          );

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      tasksList.value =
          categoryMapList.map((map) => TaskModel.fromMap(map)).where((task) {
            final startTime = task.startTime;
            final startDate = DateTime(
              startTime.year,
              startTime.month,
              startTime.day,
            );
            return startDate == today;
          }).toList();
    } catch (e) {
      log('Error fetching tasks by user ID: $e');
      tasksList.clear();
    }
  }

  void showNotification(String title, String body) {
    AwesomeNotifications()
        .createNotification(
          content: NotificationContent(
            id: 10,
            autoDismissible: true,
            channelKey: 'basic_channel',
            title: title,
            body: body,
          ),
        )
        .then((value) {
          Get.snackbar(
            title,
            body,
            backgroundColor: AppColors.black,
            colorText: AppColors.white,
          );
        });
  }

  Timer? notificationTimer;

  void startNotificationScheduler() {
    notificationTimer = Timer.periodic(Duration(seconds: 60), (_) {
      final now = DateTime.now();
      for (var task in tasksList) {
        final startTime = task.startTime;
        final startDate = DateTime(
          startTime.year,
          startTime.month,
          startTime.day,
          startTime.hour,
          startTime.minute,
        );
        if (startDate.isBefore(now.add(Duration(seconds: 60))) &&
            startDate.isAfter(now.subtract(Duration(seconds: 60)))) {
          showNotification(
            task.taskTitle,
            "${DateFormat('yyyy-MM-dd HH:mm').format(task.startTime)} - ${DateFormat('yyyy-MM-dd HH:mm').format(task.endTime)}",
          );
        }
      }
    });
  }

  void stopNotificationScheduler() {
    notificationTimer?.cancel();
  }
}
