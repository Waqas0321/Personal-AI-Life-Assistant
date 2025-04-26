import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void saveTask() {
    // You can later add saving to database or storage here
    log('Task Saved: ${titleController.text} - ${descriptionController.text}');
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}