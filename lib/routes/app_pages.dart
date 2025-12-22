// lib/routes/app_pages.dart
import 'package:get/get.dart';
import 'app_routes.dart';
import '../modules/splash/splash_view.dart';
import '../modules/login/login_view.dart';
import '../modules/dashboard/dashboard_view.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardView(),
    ),
  ];
}
