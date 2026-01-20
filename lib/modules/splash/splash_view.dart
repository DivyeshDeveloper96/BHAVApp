// lib/modules/splash/splash_view.dart
import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:bhavapp/routes/page_identifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
     Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(PageIdentifier.dashboard.name);
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [ColorConstant.kSecondary, ColorConstant.kPrimary],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/gm_logo.png',
              fit: BoxFit.cover,
              height: MediaQuery.sizeOf(context).height * 0.2,
              width: MediaQuery.sizeOf(context).width * 0.4,
            ),
            /* Text(
              'Bhakti Ashraya Vaisnava Swami',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: 0.3,
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),*/
            Image.asset(
              'assets/images/signature.png',
              fit: BoxFit.cover,
              height: 32,
              width: MediaQuery.sizeOf(context).width * 0.6,
            ),
            SizedBox(height: 10),
            Text(
              'Official Mobile App',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
