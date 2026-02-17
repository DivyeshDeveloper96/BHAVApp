import 'package:bhavapp/modules/login/view/login_view.dart';
import 'package:bhavapp/modules/more/socialmedia/view/followUsOnSocialMedia.dart';
import 'package:bhavapp/modules/signup/view/signup_view.dart';
import 'package:bhavapp/modules/splash/view/splash_view.dart';
import 'package:bhavapp/modules/youtubeSample/pages/youtube_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/dashboard/view/dashboard_view.dart';
import '../modules/home/view/home_view.dart';
import '../modules/login/view/verifyOtp_view.dart';
import '../modules/profile/view/profile_view.dart';
import '../modules/settings/view/settings_view.dart';
import '../modules/yatras/view/billpaymentHistory_view.dart';
import '../modules/yatras/view/contactUs_view.dart';
import '../modules/yatras/view/myRegistrations_view.dart';
import '../modules/yatras/view/registrationDetails_view.dart';
import '../modules/yatras/view/yatraDetails_view.dart';

enum PageIdentifier {
  initial,
  login,
  dashboard,
  home,
  audio,
  books,
  qa,
  settings,
  myRegistraions,
  yatraDetails,
  billPaymentHistory,
  contactUs,
  registraionDeatils,
  verifyotp,
  youtubepage,
  signup,
  profile,
  followsocialmedia;

  get name {
    switch (this) {
      case initial:
        return '/';
      case login:
        return '/login';
      case dashboard:
        return '/dashboard';
      case home:
        return '/home';
      case audio:
        return '/audio';
      case books:
        return '/books';
      case qa:
        return '/qa';
      case settings:
        return '/settings';
      case myRegistraions:
        return '/myRegistraions';
      case yatraDetails:
        return '/yatraDetails';
      case billPaymentHistory:
        return '/billPaymentHistory';
      case contactUs:
        return '/contactUs';
      case registraionDeatils:
        return '/registraionDeatils';
      case verifyotp:
        return '/verifyotp';
      case youtubepage:
        return '/youtubepage';
      case followsocialmedia:
        return '/followsocialmedia';
      case signup:
        return '/signup';
      case profile:
        return '/profile';
      default:
        return '/';
    }
  }

  static Widget getPage(PageIdentifier id) {
    switch (id) {
      case initial:
        return SplashView();
      case login:
        return LoginView();
      case dashboard:
        return DashboardView();
      case home:
        return HomeView();
      case settings:
        return SettingsView();
      case myRegistraions:
        return MyRegistrationsView();
      case yatraDetails:
        return YatraDetailsView();
      case billPaymentHistory:
        return BillPaymentPage();
      case contactUs:
        return ContactView();
      case registraionDeatils:
        return RegistrationDetailsView();
      case verifyotp:
        return OtpVerificationView(Get.arguments as String);
      case youtubepage:
        return YouTubeListPage();
      case followsocialmedia:
        return const SocialMediaLinksPage();
      case signup:
        return const SignupView();
      case profile:
        return const ProfileView();
      default:
        return SplashView();
    }
  }

  // get binding
  static Bindings? getBinding(PageIdentifier id) {
    switch (id) {
      /*case PageIdentifier.profile:
        return ProfileBinding();*/
      /*case PageIdentifier.root:
        return _bindController<RootController>(RootController());
      case PageIdentifier.contactsupport:
        return _bindController<PrashastHelpController>(
          PrashastHelpController(),
        );
      case PageIdentifier.notification:
      case PageIdentifier.receivedNotificationDetail:
        return _bindController<NotificationController>(
          NotificationController(),
        );
      case PageIdentifier.manageKyc:
      case PageIdentifier.login:
        return _bindController<AuthController>(AuthController());*/
      default:
        return null;
    }
  }

  static Bindings _bindController<T extends GetxController>(T controller) {
    return BindingsBuilder(() => Get.lazyPut<T>(() => controller));
  }
}
