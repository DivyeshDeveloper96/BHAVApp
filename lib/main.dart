import 'package:bhavapp/flutter_options.dart';
import 'package:bhavapp/routes/page_factory.dart';
import 'package:bhavapp/routes/page_identifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/themes/app_theme.dart';
import 'core/themes/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Spiritual Base App",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode.value,
        initialRoute: PageIdentifier.initial.name,
        getPages: PageFactory.getPages,
      ),
    );
  }
}
