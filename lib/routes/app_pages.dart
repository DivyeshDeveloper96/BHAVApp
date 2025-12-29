// lib/routes/app_pages.dart
import 'package:bhavapp/modules/login/verifyOtp_view.dart';
import 'package:bhavapp/modules/yatras/billpaymentHistory_view.dart';
import 'package:bhavapp/modules/yatras/contactUs_view.dart';
import 'package:bhavapp/modules/yatras/myRegistrations_view.dart';
import 'package:bhavapp/modules/yatras/registrationDetails_view.dart';
import 'package:bhavapp/modules/yatras/yatraDetails_view.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import '../modules/splash/splash_view.dart';
import '../modules/login/login_view.dart';
import '../modules/dashboard/dashboard_view.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.login, page: () => const LoginView()),
    GetPage(name: Routes.dashboard, page: () => const DashboardView()),
    GetPage(name: Routes.yatraDetails, page: () => const YatraDetailsView()),
    GetPage(
      name: Routes.billPaymentHistory,
      page: () => const BillPaymentPage(),
    ),
    GetPage(name: Routes.contactUs, page: () => const ContactView()),
    GetPage(
      name: Routes.myRegistraions,
      page: () => const MyRegistrationsView(),
    ),
    GetPage(
      name: Routes.registraionDeatils,
      page: () => const RegistrationDetailsView(),
    ),
    GetPage(
      name: Routes.verifyotp,
      page: () => const OtpVerificationView(),
    ),
  ];
}
