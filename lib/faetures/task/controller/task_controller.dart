import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_toast_show.dart';
import '../../../data/models/task_model.dart';

class TaskController extends GetxController {
  ToastClass toast = ToastClass();
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

  Future<void> addTask() async {
    if (titleController.text.trim().isEmpty) {
      toast.showCustomToast("Title is required!");
      return;
    }

    isLoading.value = true;

    try {
      final doc = FirebaseFirestore.instance.collection('tasks').doc();
      final task = TaskModel(
        id: doc.id,
        title: titleController.text.trim(),
        startTime: startTime.value,
        endTime: endTime.value,
        category: selectedCategory.value,
      );

      await doc.set(task.toMap());
      toast.showCustomToast('Task added successfully');
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
    selectedCategory.value = 'Work';
    startTime.value = DateTime.now();
    endTime.value = DateTime.now();
  }
}
