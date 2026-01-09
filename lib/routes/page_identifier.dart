import 'package:bhavapp/modules/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PageIdentifier {
  initial,
  profile,
  login;

  get name {
    switch (this) {
      case initial:
        return '/';
      case profile:
        return '/profile';
      case login:
        return '/login';
    }
  }

  static Widget getPage(PageIdentifier id) {
    switch (id) {
      case initial:
        return SplashView();
      case profile:
        return SplashView();
      case login:
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
