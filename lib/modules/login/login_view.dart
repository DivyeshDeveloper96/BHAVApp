// lib/modules/login/login_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Regular login would go here
                Get.offAllNamed(Routes.dashboard);
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Guest login
                Get.offAllNamed(Routes.dashboard);
              },
              child: const Text('Continue as Guest'),
            )
          ],
        ),
      ),
    );
  }
}
