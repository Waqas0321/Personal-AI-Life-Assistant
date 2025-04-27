import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_toast_show.dart';
import '../../../../data/providers/user_provider.dart';

class ForgetPasswordController extends GetxController {
  final ToastClass toast = ToastClass();
  TextEditingController emailController = TextEditingController();
  UserProvider auth = UserProvider();
  RxBool isLoading = false.obs;

  Future<void> resetPassword() async {
    try {
      isLoading.value = true;
      await auth.resetPassword(emailController.text.trim()).then((value) {
        emailController.clear();
        return Get.back();
      });
    } catch (e) {
      log("Exception : $e");
    } finally {
      isLoading.value = false;
    }
  }
}
