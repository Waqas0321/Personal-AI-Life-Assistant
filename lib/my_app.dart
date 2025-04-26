import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/Const/app_colors.dart';
import 'core/Theme/app_theme.dart';
import 'core/app_routes/app_pages.dart';
import 'core/app_routes/routes.dart';
import 'core/bindings/initial_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.darkBlue,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: "LexiLearn",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.SPLASHSCREEN,
      getPages: AppPages.routes,
    );
  }
}
