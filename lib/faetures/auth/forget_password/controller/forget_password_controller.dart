import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_toast_show.dart';

class ForgetPasswordController extends GetxController{
  final ToastClass toast = ToastClass();
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;

}