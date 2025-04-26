import 'dart:developer';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/data/models/task_model.dart';
import '../../../../core/widgets/custom_toast_show.dart';
import '../../../../data/providers/local_database/database_helper.dart';
import '../../../../data/providers/local_database/databse_constants.dart';
import '../../../../data/shared_preference/shared_preference_services.dart';

class TasksListController extends GetxController {
  ToastClass toast = ToastClass();
  RxList<TaskModel> tasksList = <TaskModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getTasksByUserId();
  }

  Future<void> getTasksByUserId() async {
    try {
      String? userId = await PreferenceHelper.getString("userID");
      if (userId == null) {
        tasksList.clear();
        return;
      }
      print("User id : $userId");

      List<Map<String, dynamic>> categoryMapList = await DatabaseHelper().getListById(
        DatabaseConstants.tasksTable,
        DatabaseConstants.columnUserId,
        userId,
      );

      tasksList.value = categoryMapList
          .map((map) => TaskModel.fromMap(map))
          .toList();
    } catch (e) {
      log('Error fetching tasks by user ID: $e');
      tasksList.clear();
    }
  }

  Future<void> deleteTask(int taskID) async {
    try {
      int result = await DatabaseHelper().delete(
        DatabaseConstants.tasksTable,
        "${DatabaseConstants.columnTaskId} = ?",
        [taskID],
      );
      if (result > 0) {
        toast.showCustomToast("Category deleted successfully!");
        await getTasksByUserId();
      } else {
        toast.showCustomToast("Failed to delete category!");
      }
    } catch (e) {
      print("Exception $e");
      toast.showCustomToast("Failed to delete category!");
    }
  }
}
