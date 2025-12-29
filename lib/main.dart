import 'package:bhavapp/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/themes/app_theme.dart';
import 'core/themes/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController()); // Initialize theme controller
  /*await Supabase.initialize(
    url: 'https://YOUR_PROJECT_ID.supabase.co',
    anonKey: 'YOUR_ANON_KEY',
  );*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() =>
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Spiritual Base App",
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode.value,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        ));
  }
}