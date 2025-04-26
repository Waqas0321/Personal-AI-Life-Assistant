import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_toast_show.dart';
import 'package:personal_ai_life_assistant/data/shared_preference/shared_preference_services.dart';
import 'package:personal_ai_life_assistant/faetures/task/tasks_list/controller/tasks_list_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../../data/models/task_model.dart';
import '../../../../data/providers/local_database/database_helper.dart';
import '../../../../data/providers/local_database/databse_constants.dart';

class TaskController extends GetxController {
  ToastClass toast = ToastClass();
  ImagePicker imagePicker = ImagePicker();
  TasksListController tasksListController = Get.put(TasksListController());
  DatabaseHelper dbHelper = DatabaseHelper();
  final titleController = TextEditingController();
  final categoryList = ['Academics', 'Social', 'Personal', 'Health'];

  var selectedCategory = 'Academics'.obs;
  var startTime = DateTime.now().obs;
  var endTime = DateTime.now().obs;
  var isLoading = false.obs;

  void setStartTime(DateTime pickedDate) {
    startTime.value = pickedDate;
  }

  void setEndTime(DateTime pickedDate) {
    endTime.value = pickedDate;
  }

  void setCategory(String value) {
    selectedCategory.value = value;
  }

  final stt.SpeechToText speech = stt.SpeechToText();

  var isListening = false.obs;

  void startListening() async {
    bool available = await speech.initialize();
    if (available) {
      isListening.value = true;
      speech.listen(
        onResult: (result) {
          titleController.text = result.recognizedWords;
        },
      );
    } else {
      toast.showCustomToast('Speech recognition not available');
    }
  }

  void stopListening() {
    speech.stop();
    isListening.value = false;
  }

  Future<void> addTask() async {
    if (titleController.text.trim().isEmpty) {
      toast.showCustomToast("Title is required!");
      return;
    }
    try {
      isLoading.value = true;
      String? userID = await PreferenceHelper.getString("userID");
      final task = TaskModel(
        taskTitle: titleController.text.trim(),
        startTime: startTime.value,
        userId: userID,
        endTime: endTime.value,
        category: selectedCategory.value,
      );
      await dbHelper.insert(DatabaseConstants.tasksTable, task);
      toast.showCustomToast('Task added successfully');
      tasksListController.onInit();
      Get.back();
      clearFields();
    } catch (e) {
      toast.showCustomToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> updateTask(int taskId) async {
    try {
      isLoading.value = true;
      String? userID = await PreferenceHelper.getString("userID");
      final task = TaskModel(
        taskId: taskId,
        taskTitle: titleController.text.trim(),
        startTime: startTime.value,
        userId: userID,
        endTime: endTime.value,
        category: selectedCategory.value,
      );
      await dbHelper.update(DatabaseConstants.tasksTable, task,DatabaseConstants.columnTaskId,[taskId]);
      toast.showCustomToast('Task Updated successfully');
      tasksListController.onInit();
      Get.back();
      clearFields();
    } catch (e) {
      toast.showCustomToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickDateTime(BuildContext context, bool isStartTime) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (isStartTime) {
          setStartTime(finalDateTime);
        } else {
          setEndTime(finalDateTime);
        }
      }
    }
  }

  void clearFields() {
    titleController.clear();
    selectedCategory.value = 'Academics';
    startTime.value = DateTime.now();
    endTime.value = DateTime.now();
  }
}
