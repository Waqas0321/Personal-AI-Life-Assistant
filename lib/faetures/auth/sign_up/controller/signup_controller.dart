import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_toast_show.dart';
import '../../../../data/providers/image_picker.dart';

class SignUpController extends GetxController {
  ImagePickerHelper imagePicker = ImagePickerHelper();
  ToastClass toast = ToastClass();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  RxString selectedGender = 'Male'.obs;
  File? imagePath = ImagePickerHelper().selectedImage.value;
  RxBool isLoading = false.obs;


  void refreshField(){
    imagePicker.selectedImage.value = null;
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    createPasswordController.clear();
    confirmPasswordController.clear();
    aboutController.clear();
    selectedGender.value = 'Male';
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
