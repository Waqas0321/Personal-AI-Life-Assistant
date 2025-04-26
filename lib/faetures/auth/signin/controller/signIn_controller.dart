import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/custom_toast_show.dart';
class SignInController extends GetxController {
  ToastClass toast = ToastClass();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
}
