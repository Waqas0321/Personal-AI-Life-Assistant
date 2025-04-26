import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_ai_life_assistant/core/widgets/custom_text_widget.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController controller = Get.find();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Dashboard",
          ),
          body:Center(child: CustomTextWidget(text: "Home"),),
        );
      },
    );
  }
}
