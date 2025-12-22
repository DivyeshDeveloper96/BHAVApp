// lib/modules/settings/settings_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/themes/theme_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: ListView(
        children: [
          Obx(
            () => SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeController.themeMode.value == ThemeMode.dark,
              onChanged: (val) => themeController.toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }
}
