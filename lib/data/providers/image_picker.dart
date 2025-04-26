import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/Const/app_colors.dart';
import '../../core/widgets/custom_text_widget.dart';

class ImagePickerHelper {
  final Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
    Get.back();
  }
  void showImagePickerBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
        decoration: const BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.whitish, blurRadius: 12, spreadRadius: -4)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.white),
              title: const CustomTextWidget(
                text: "Pick from Gallery",
                textAlign: TextAlign.start,
                textColor: AppColors.white,
              ),
              onTap: () => pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera, color: AppColors.white),
              title: const CustomTextWidget(
                text: "Take a Photo",
                textAlign: TextAlign.start,
                textColor: AppColors.white,
              ),
              onTap: () => pickImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
