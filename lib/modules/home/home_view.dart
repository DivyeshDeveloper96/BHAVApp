// lib/modules/home/home_view.dart
import 'package:flutter/material.dart';
import 'home_controller.dart';
import 'package:get/get.dart' show Get, Inst;

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // This can later be converted into a GetX Builder with an API call
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Welcome to the Spiritual App\n(Dynamic content can load here)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
